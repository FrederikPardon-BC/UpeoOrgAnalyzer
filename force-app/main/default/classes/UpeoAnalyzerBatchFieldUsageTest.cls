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
 * Created: 14/11/2021
 * Last Updated: 14/11/2021
 *
 * Unit tests:
 *
 * Change log:
 * -----------------------------------------------------------------------------------------------
*/
@IsTest
private class UpeoAnalyzerBatchFieldUsageTest {
    @IsTest
    static void testrBatchFieldUsage() {

        Account a = new Account();
        a.Name = 'Test';
        insert a;



        String objString = 'Account';
        SObjectType type = Schema.getGlobalDescribe().get('Account');
        Map<String, Schema.SObjectField> fieldMap = type.getDescribe().fields.getMap();
        Set<String> setFieldName = fieldMap.keySet();
        List<String> lstFieldNames = new List<String>(setFieldName);

        String qry = 'SELECT ' + String.join(lstFieldNames, ',') + ' FROM ' + objString;
        system.debug(qry);

        Test.startTest();

        UpeoAnalyzerBatchFieldUsage job = new UpeoAnalyzerBatchFieldUsage(qry, fieldMap, objString);
        DataBase.executeBatch(job);

        Test.stopTest();

        list<Additional_Org_Metrics__c> aomList = [SELECT Id FROM Additional_Org_Metrics__c];


        System.assertNotEquals(0, aomList.size());





    }
}