/**
 * @Version: 1.0
 * @Author: Frederik
 * @Copyright: 2021 Upeo Consulting
 * @Uses:
 *
 * -----------------------------------------------------------------------------------------------
 * Description: 
 *
 *
 * Created: 15/11/2021
 * Last Updated: 15/11/2021
 *
 * Unit tests:
 *
 * Change log:
 * -----------------------------------------------------------------------------------------------
*/
public with sharing class UpeoAnalyzerBatchProcessBuilder implements Database.Batchable<sObject>, Database.AllowsCallouts {



    public Database.QueryLocator start(Database.BatchableContext BC) {

        string filteVar = 'Process Builder';
        String filter = ' WHERE Category__c = \'' + String.escapeSingleQuotes(filteVar) + '\'';
        String query = 'Select Component_Id__c, External_Id__c, Component_Name__c from Additional_Org_Metrics__c' +filter;
        system.debug(query);
        return Database.getQueryLocator(query);

    }

    public void execute(Database.BatchableContext BC, List<Additional_Org_Metrics__c> scope) {

        List<Additional_Org_Metrics__c> aomList = new List<Additional_Org_Metrics__c>();

        for(SObject obj : scope){

            Additional_Org_Metrics__c aom = (Additional_Org_Metrics__c) obj;

            String baseUrl = 'callout:UpeoOptimizer';
            String path = '/services/data/v43.0/tooling/sobjects/Flow/';
            String flowId = aom.Component_Id__c;

            String qUrl = baseUrl+path+flowId;

            String responseBody = UpeoAnalyzerToolingRequest.request(qUrl);

            UpeoAnalyzerPBDetailWrapper parsedResult = UpeoAnalyzerPBDetailWrapper.parse(responseBody);

            Map<String, String> resultMap = new Map <String, String>();

            for(UpeoAnalyzerPBDetailWrapper.cls_processMetadataValues type : parsedResult.Metadata.processMetadataValues){
                resultMap.put(type.name, type.value.stringValue);
            }

            aom.Object__c = resultMap.get('ObjectType');
            aom.Flow_Trigger_Type__c = resultMap.get('TriggerType');
            if (parsedResult.Status == 'Active'){
                aom.Active__c = true;
            }
            aomList.add(aom);

        }

        upsert aomList External_Id__c;



    }

    public void finish(Database.BatchableContext BC){

    }



}