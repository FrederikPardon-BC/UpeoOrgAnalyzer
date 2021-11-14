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
private class UpeoAnalyzerGetMetricsControllerTest {
    @IsTest
    static void getOrgMetricsTest() {

        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();

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



        SingleRequestMock wfrBasicMock2 = new SingleRequestMock(200,
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


        endpoint2TestResp.put('callout:UpeoOptimizer/services/data/v47.0/tooling/query/?q=Select+Id,Name,TableEnumOrId+From+WorkflowRule',wfrBasicMock);
        endpoint2TestResp.put('/services/data/v47.0/tooling/sobjects/WorkflowRule/01Q090000001sk8EAA',wfrDetailMock);
        endpoint2TestResp.put('callout:UpeoOptimizer/services/data/v52.0/limits/recordCount',fakeObjectCount);
        endpoint2TestResp.put('callout:UpeoOptimizer/services/data/v52.0/limits',fakeLimitResp);
        endpoint2TestResp.put('callout:UpeoOptimizer/services/data/v47.0/tooling/query/?q=SELECT+Id,ValidationName,Active,EntityDefinition.DeveloperName,ErrorMessage+FROM+ValidationRule',wfrBasicMock2);

        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);

        UpeoAnalyzerGetMetricsController.getOrgMetrics();




    }
}