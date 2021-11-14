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
public with sharing class UpeoAnalyzerTest {

    @IsTest(SeeAllData=true)
    static void getFlowMetricsTest(){

        List<FlowInterviewLog> flowLogs = [select Name, CreatedDate, CreatedBy.Name, FlowDeveloperName, InterviewStartTimestamp, InterviewEndTimestamp, InterviewDurationInMinutes, InterviewStatus, FlowLabel from FlowInterviewLog];
        FlowDefinitionView flowData = [select Id, Label, ApiName, Description, ProcessType, TriggerType from FlowDefinitionView Limit 1];
        String flowName = flowData.ApiName;
        system.debug(flowName);

        UpeoAnalyzer.getFlowMetrics();

        List<Additional_Org_Metrics__c> flowMetrics = [Select Id, Name, Component_Name__c from Additional_Org_Metrics__c where Category__c = 'Flow' And Feature_Type__c = 'Flow Runtimes' and Flow_Name__c = :flowName];

        if(flowLogs.size() == 0) {
            system.assertEquals(flowMetrics.size(), 0);
        } else {

            for (Additional_Org_Metrics__c flow : flowMetrics) {
            system.assertEquals(flowMetrics.size(), 1);
            }
        }

    }

    @IsTest
    static void getLimitsTest(){

        Test.startTest();

        SingleRequestMock fakeLimitResp = new SingleRequestMock(200,
                'Complete',
                '{\n' +
                        '  "DataStorageMB" : {\n' +
                        '    "Max" : 10280,\n' +
                        '    "Remaining" : 10278\n' +
                        '  },\n' +
                        '  "FileStorageMB" : {\n' +
                        '    "Max" : 12800,\n' +
                        '    "Remaining" : 12791\n' +
                        '  },\n' +
                        '  "PermissionSets" : {\n' +
                        '    "Max" : 1500,\n' +
                        '    "Remaining" : 1490,\n' +
                        '    "CreateCustom" : {\n' +
                        '      "Max" : 1000,\n' +
                        '      "Remaining" : 996\n' +
                        '    }\n' +
                        '  }\n' +
                        '}',
                null);

        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put('callout:UpeoOptimizer/services/data/v52.0/limits',fakeLimitResp);
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);

        UpeoAnalyzer.getLimits();

        test.stopTest();

        List<Additional_Org_Metrics__c> limitList = [Select Id from Additional_Org_Metrics__c];
        system.assertEquals(3, limitList.size());

    }

    @IsTest
    public static void getSobjectRecordCountTest(){

        Test.startTest();

        SingleRequestMock fakeObjectCount = new SingleRequestMock(200,
                'Complete',
                '{\n' +
                        '  "sObjects" : [ {\n' +
                        '    "count" : 65,\n' +
                        '    "name" : "Account"\n' +
                        '  }, {\n' +
                        '    "count" : 58,\n' +
                        '    "name" : "Contact"\n' +
                        '  }]\n' +
                        '}',
                null);

        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put('callout:UpeoOptimizer/services/data/v52.0/limits/recordCount',fakeObjectCount);
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);

        UpeoAnalyzer.getSobjectRecordCount();

        test.stopTest();

        List<Additional_Org_Metrics__c> limitList = [Select Id from Additional_Org_Metrics__c];
        system.assertEquals(2, limitList.size());


    }

    @IsTest
    public static void getOldRecordDateTest() {

        Additional_Org_Metrics__c aom = new Additional_Org_Metrics__c();
        aom.Object__c = 'Account';
        aom.Feature_Type__c = 'Large Volumes';
        aom.External_Id__c = '123';

        insert aom;

        UpeoAnalyzer.getOldRecordDate();

        Additional_Org_Metrics__c aomAfterUpdate = [Select Id, Number_of_Old_Records__c FROM Additional_Org_Metrics__c];
        system.AssertEquals(aomAfterUpdate.Number_of_Old_Records__c, 0);

    }

    @IsTest
    public static void getWorkflowRulesTest(){

        Test.startTest();

        SingleRequestMock wfrBasicMock = new SingleRequestMock(200,
                'Complete',
                '{\n' +
                        '  "size" : 1,\n' +
                        '  "totalSize" : 1,\n' +
                        '  "done" : true,\n' +
                        '  "queryLocator" : null,\n' +
                        '  "entityTypeName" : "WorkflowRule",\n' +
                        '  "records" : [ {\n' +
                        '    "attributes" : {\n' +
                        '      "type" : "WorkflowRule",\n' +
                        '      "url" : "/services/data/v47.0/tooling/sobjects/WorkflowRule/01Q090000001sk8EAA"\n' +
                        '    },\n' +
                        '    "Id" : "01Q090000001sk8EAA",\n' +
                        '    "Name" : "New Service Order - Must be Draft Status",\n' +
                        '    "TableEnumOrId" : "CHANNEL_ORDERS__Service_Order__c"\n' +
                        '  }]\n' +
                        '}',
                null);

        SingleRequestMock wfrDetailMock = new SingleRequestMock(200,
                'Complete',
                '{\n' +
                        '  "attributes" : {\n' +
                        '    "type" : "WorkflowRule",\n' +
                        '    "url" : "/services/data/v47.0/tooling/sobjects/WorkflowRule/01Q090000001sk8EAA"\n' +
                        '  },\n' +
                        '  "Id" : "01Q090000001sk8EAA",\n' +
                        '  "Name" : "New Service Order - Must be Draft Status",\n' +
                        '  "TableEnumOrId" : "CHANNEL_ORDERS__Service_Order__c",\n' +
                        '  "ManageableState" : "installed",\n' +
                        '  "NamespacePrefix" : "CHANNEL_ORDERS",\n' +
                        '  "CreatedDate" : "2021-08-05T12:47:36.000+0000",\n' +
                        '  "CreatedById" : "00509000008deYLAAY",\n' +
                        '  "LastModifiedDate" : "2021-08-05T12:47:36.000+0000",\n' +
                        '  "LastModifiedById" : "00509000008deYLAAY",\n' +
                        '  "Metadata" : {\n' +
                        '    "actions" : [ {\n' +
                        '      "name" : "CHANNEL_ORDERS__New_Service_Order_Must_be_Draft_Status",\n' +
                        '      "type" : "FieldUpdate"\n' +
                        '    } ],\n' +
                        '    "booleanFilter" : null,\n' +
                        '    "criteriaItems" : [ {\n' +
                        '      "field" : "CHANNEL_ORDERS__Service_Order__c.CHANNEL_ORDERS__Service_Order_Status__c",\n' +
                        '      "operation" : "notEqual",\n' +
                        '      "value" : "Draft",\n' +
                        '      "valueField" : null\n' +
                        '    } ],\n' +
                        '    "formula" : null,\n' +
                        '    "urls" : null,\n' +
                        '    "workflowTimeTriggers" : [ ],\n' +
                        '    "active" : true,\n' +
                        '    "description" : null,\n' +
                        '    "triggerType" : "onCreateOnly"\n' +
                        '  },\n' +
                        '  "FullName" : "CHANNEL_ORDERS__Service_Order__c.CHANNEL_ORDERS__New Service Order - Must be Draft Status"\n' +
                        '}',
                null);




        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put('callout:UpeoOptimizer/services/data/v47.0/tooling/query/?q=Select+Id,Name,TableEnumOrId+From+WorkflowRule',wfrBasicMock);
        endpoint2TestResp.put('/services/data/v47.0/tooling/sobjects/WorkflowRule/01Q090000001sk8EAA',wfrDetailMock);
        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);

        UpeoAnalyzer.getWorkflowRules();

        test.stopTest();

        List<Additional_Org_Metrics__c> aomList = [Select Id From Additional_Org_Metrics__c where Category__c = 'Workflow'];
        system.assertEquals(1, aomList.size());


    }

    @IsTest
    public static void getActiveValidationRulesTest(){

        Test.startTest();

        SingleRequestMock wfrBasicMock = new SingleRequestMock(200,
                'Complete',
                '{\n' +
                        '  "size" : 2,\n' +
                        '  "totalSize" : 2,\n' +
                        '  "done" : true,\n' +
                        '  "queryLocator" : null,\n' +
                        '  "entityTypeName" : "ValidationRule",\n' +
                        '  "records" : [ {\n' +
                        '    "attributes" : {\n' +
                        '      "type" : "ValidationRule",\n' +
                        '      "url" : "/services/data/v47.0/tooling/sobjects/ValidationRule/03d09000000EvPsAAK"\n' +
                        '    },\n' +
                        '    "Id" : "03d09000000EvPsAAK",\n' +
                        '    "ValidationName" : "Country_2_letter_code",\n' +
                        '    "Active" : true,\n' +
                        '    "EntityDefinition" : {\n' +
                        '      "attributes" : {\n' +
                        '        "type" : "EntityDefinition",\n' +
                        '        "url" : "/services/data/v47.0/tooling/sobjects/EntityDefinition/01I09000001k9OD"\n' +
                        '      },\n' +
                        '      "DeveloperName" : "Customer"\n' +
                        '    },\n' +
                        '    "ErrorMessage" : "(deprecated)"\n' +
                        '  }, {\n' +
                        '    "attributes" : {\n' +
                        '      "type" : "ValidationRule",\n' +
                        '      "url" : "/services/data/v47.0/tooling/sobjects/ValidationRule/03d09000000EvPtAAK"\n' +
                        '    },\n' +
                        '    "Id" : "03d09000000EvPtAAK",\n' +
                        '    "ValidationName" : "Invalid_OrgID",\n' +
                        '    "Active" : true,\n' +
                        '    "EntityDefinition" : {\n' +
                        '      "attributes" : {\n' +
                        '        "type" : "EntityDefinition",\n' +
                        '        "url" : "/services/data/v47.0/tooling/sobjects/EntityDefinition/01I09000001k9OD"\n' +
                        '      },\n' +
                        '      "DeveloperName" : "Customer"\n' +
                        '    },\n' +
                        '    "ErrorMessage" : "(deprecated)"\n' +
                        '  }]\n' +
                        '  }',
                null);


        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put('callout:UpeoOptimizer/services/data/v47.0/tooling/query/?q=SELECT+Id,ValidationName,Active,EntityDefinition.DeveloperName,ErrorMessage+FROM+ValidationRule',wfrBasicMock);

        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);

        UpeoAnalyzer.getActiveValidationRules();

        test.stopTest();

        List<Additional_Org_Metrics__c> aomList = [Select Id From Additional_Org_Metrics__c where Category__c = 'Validation Rules'];
        system.assertEquals(2, aomList.size());

    }

    @IsTest
    public static void getFieldUsageTest(){

        Test.startTest();

        List<String> objectTypes = new list<string>{'Account','Contact'};
        UpeoAnalyzer.getFieldUsage(objectTypes);

        Test.stopTest();

        List<Additional_Org_Metrics__c> aomList = [Select Id From Additional_Org_Metrics__c where Category__c = 'Fields'];
        system.debug(aomList.size());


    }

    @IsTest
    public static void getRecordCountsTest(){

        Test.startTest();

        List<String> objectTypes = new list<string>{'Account','Contact'};
        UpeoAnalyzer.getRecordCounts(objectTypes);

        Test.stopTest();

        List<Additional_Org_Metrics__c> aomList = [Select Id From Additional_Org_Metrics__c];
        system.debug(aomList.size());


    }

    @IsTest
    public static void geSelectedFieldUsageTest(){

        Test.startTest();

        List<String> fieldTypes = new list<string>{'Name','Type'};
        UpeoAnalyzer.geSelectedFieldUsage(fieldTypes, 'Account');

        Test.stopTest();

        List<Additional_Org_Metrics__c> aomList = [Select Id From Additional_Org_Metrics__c];
        system.debug(aomList.size());


    }

    @IsTest
    public static void getAllObjectsFieldDataTest(){

        test.startTest();

        UpeoAnalyzer.getAllObjectsFieldData();

        test.stopTest();

        List<Additional_Org_Metrics__c> aomList = [Select Id From Additional_Org_Metrics__c];
        System.assertNotEquals(0, aomList.size());

    }




}