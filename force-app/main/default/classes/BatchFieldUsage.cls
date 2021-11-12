/**
 * Created by fpardon on 10/11/2021.
 */

public class BatchFieldUsage implements Database.Batchable<sObject> {

    private final String Query;
    private Map<String, Schema.SObjectField> FieldMap;
    private String ObjType;

    public BatchFieldUsage(String qryString, Map<String, Schema.SObjectField> fieldMap, String objType){
        this.Query = qryString;
        this.FieldMap = fieldMap;
        this.ObjType = objType;

        system.debug('fieldMap size = ' +fieldMap.size());
        system.debug('objectType = ' +objType);
    }

    public Database.QueryLocator start(Database.BatchableContext BC) {

        return Database.getQueryLocator(query);

    }

    public void execute(Database.BatchableContext BC, List<sObject> fieldList) {


        List<Additional_Org_Metrics__c> lstOrgMetrics = new List<Additional_Org_Metrics__c>();

        system.debug('Object Type = '+ObjType);
        System.debug('Field Map Size = ' + FieldMap.size());

        for(Schema.SObjectField field :FieldMap.values()) {

            if (field.getDescribe().isPermissionable()) {

                Additional_Org_Metrics__c aom = new Additional_Org_Metrics__c();
                aom.Category__c = 'Fields';
                aom.Feature_Type__c = 'Field Usage';
                aom.Object__c = objType;
                aom.External_Id__c = objType + '-' + field.getDescribe().getName();
                aom.Custom__c = field.getDescribe().isCustom();
                system.debug(field.getDescribe().isCustom());
                system.debug(field.getDescribe().getName());
                aom.Component_Name__c = field.getDescribe().getName();
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
        }
        upsert lstOrgMetrics External_Id__c;

        system.debug('Number of metrics to be added ' +lstOrgMetrics.size());

    }

    public void finish(Database.BatchableContext BC){

    }

}