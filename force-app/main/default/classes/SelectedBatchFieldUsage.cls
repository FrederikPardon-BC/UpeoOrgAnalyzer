/**
 * Created by fpardon on 10/11/2021.
 */

public class SelectedBatchFieldUsage implements Database.Batchable<sObject> {

    private final String Query;
    private List<String> FieldStringList;
    private String ObjType;

    public SelectedBatchFieldUsage(String qryString, List<String> fieldList, String objType){
        this.Query = qryString;
        this.FieldStringList = fieldList;
        this.ObjType = objType;

        system.debug('fieldMap size = ' +fieldList.size());
        system.debug('objectType = ' +objType);
    }

    public Database.QueryLocator start(Database.BatchableContext BC) {

        return Database.getQueryLocator(query);

    }

    public void execute(Database.BatchableContext BC, List<sObject> fieldList) {


        List<Additional_Org_Metrics__c> lstOrgMetrics = new List<Additional_Org_Metrics__c>();

        system.debug('Object Type = '+ObjType);
        System.debug('Field List Size = ' + FieldList.size());
        SObjectType type = Schema.getGlobalDescribe().get(objType);
        Map<String, Schema.SObjectField> fieldMap = type.getDescribe().fields.getMap();

        for(String field :FieldStringList) {

            Additional_Org_Metrics__c aom = new Additional_Org_Metrics__c();
            aom.Category__c = 'Fields';
            aom.Feature_Type__c = 'Field Usage';
            aom.Object__c = objType;
            aom.External_Id__c = objType + '-' + field;
            aom.Custom__c = fieldMap.get(field).getDescribe().isCustom();
            aom.Component_Name__c = fieldMap.get(field).getDescribe().getName();
            aom.Records_where_Used__c = 0;
            aom.Records_where_not_Used__c = 0;
            aom.Total_Records__c = 0;

            for (SObject rec : fieldList) {
                if (rec.get(field) == null) {
                    aom.Records_where_not_Used__c++;
                    aom.Total_Records__c++;
                }
                if (rec.get(field) != null) {
                    aom.Records_where_Used__c++;
                    aom.Total_Records__c++;
                }
            }

            lstOrgMetrics.add(aom);

        }
        upsert lstOrgMetrics External_Id__c;

        system.debug('Number of metrics to be added ' +lstOrgMetrics.size());

    }

    public void finish(Database.BatchableContext BC){

    }

}