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
public with sharing class UpeoAnalyzerBatchProcessBuilder implements Database.Batchable<sObject> {



    public Database.QueryLocator start(Database.BatchableContext BC) {

        String query = 'Select Component_Id__c, External_Id__c, Component_Name__c from Additional_Org_Metrics__c where Category__c = /Process Builder/';
        system.debug(query);
        return Database.getQueryLocator(query);

    }

    public void execute(Database.BatchableContext BC, List<sObject> scope) {

        for(SObject obj : scope){
            system.debug(obj);
        }



    }

    public void finish(Database.BatchableContext BC){

    }



}