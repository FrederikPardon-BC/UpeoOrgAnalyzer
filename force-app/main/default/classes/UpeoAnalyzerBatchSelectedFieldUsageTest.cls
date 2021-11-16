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
private class UpeoAnalyzerBatchSelectedFieldUsageTest {
    @IsTest
    static void testSelectedFieldBatch() {







        String objString = 'Account';
        SObjectType type = Schema.getGlobalDescribe().get('Account');
        Map<String, Schema.SObjectField> fieldMap = type.getDescribe().fields.getMap();
        Set<String> setFieldName = fieldMap.keySet();
        List<String> lstFieldNames = new List<String>(setFieldName);

        String qry = 'SELECT ' + String.join(lstFieldNames, ',') + ' FROM ' + objString;
        system.debug(qry);

        test.startTest();


        UpeoAnalyzerBatchSelectedFieldUsage job = new UpeoAnalyzerBatchSelectedFieldUsage(qry, lstFieldNames, objString);
        DataBase.executeBatch(job);

        test.stopTest();

        list<Additional_Org_Metrics__c> aomList = [SELECT Id FROM Additional_Org_Metrics__c];



    }
}