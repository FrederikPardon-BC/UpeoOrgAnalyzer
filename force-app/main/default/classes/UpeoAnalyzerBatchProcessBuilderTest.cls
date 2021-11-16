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
 * Created: 16/11/2021
 * Last Updated: 16/11/2021
 *
 * Unit tests:
 *
 * Change log:
 * -----------------------------------------------------------------------------------------------
*/
@IsTest
private class UpeoAnalyzerBatchProcessBuilderTest {

    @IsTest
    static void batchTest() {

        test.startTest();

        Additional_Org_Metrics__c aom = new Additional_Org_Metrics__c();
        Additional_Org_Metrics__c aom2 = new Additional_Org_Metrics__c();

        aom.Component_Id__c = '3017Z000000pdWwQAI';
        aom.External_Id__c = 'ProcessBuilder-'+aom.Component_Id__c;
        aom.Component_Name__c = 'Account';
        aom.Category__c = 'Process Builder';

        aom2.Component_Id__c = '3017Z000000pcihQAA';
        aom2.External_Id__c = 'ProcessBuilder-'+aom2.Component_Id__c;
        aom2.Component_Name__c = 'Account';
        aom2.Category__c = 'Process Builder';

        insert aom;
        insert aom2;

        SingleRequestMock pbBaseCall = new SingleRequestMock(200,
                'Complete',
                '{\n' +
                        '  "size" : 2,\n' +
                        '  "totalSize" : 2,\n' +
                        '  "done" : true,\n' +
                        '  "queryLocator" : null,\n' +
                        '  "entityTypeName" : "AggregateResult",\n' +
                        '  "records" : [ {\n' +
                        '    "attributes" : {\n' +
                        '      "type" : "AggregateResult"\n' +
                        '    },\n' +
                        '    "DeveloperName" : "Account",\n' +
                        '    "expr0" : 1\n' +
                        '  }, {\n' +
                        '    "attributes" : {\n' +
                        '      "type" : "AggregateResult"\n' +
                        '    },\n' +
                        '    "DeveloperName" : "Lead_Insert_Update",\n' +
                        '    "expr0" : 1\n' +
                        '  } ]\n' +
                        '}',
                null);

        SingleRequestMock pbActiveCall = new SingleRequestMock(200,
                'Complete',
                '{\n' +
                        '  "size" : 2,\n' +
                        '  "totalSize" : 2,\n' +
                        '  "done" : true,\n' +
                        '  "queryLocator" : null,\n' +
                        '  "entityTypeName" : "Flow",\n' +
                        '  "records" : [ {\n' +
                        '    "attributes" : {\n' +
                        '      "type" : "Flow",\n' +
                        '      "url" : "/services/data/v51.0/tooling/sobjects/Flow/3017Z000000pdWwQAI"\n' +
                        '    },\n' +
                        '    "Id" : "3017Z000000pdWwQAI",\n' +
                        '    "Definition" : {\n' +
                        '      "attributes" : {\n' +
                        '        "type" : "FlowDefinition",\n' +
                        '        "url" : "/services/data/v51.0/tooling/sobjects/FlowDefinition/3007Z000000LCODQA4"\n' +
                        '      },\n' +
                        '      "DeveloperName" : "Account"\n' +
                        '    },\n' +
                        '    "Status" : "Active"\n' +
                        '  }]\n' +
                        '}',
                null);

        SingleRequestMock pbInactiveCall = new SingleRequestMock(200,
                'Complete',
                '{\n' +
                        '  "size" : 1,\n' +
                        '  "totalSize" : 1,\n' +
                        '  "done" : true,\n' +
                        '  "queryLocator" : null,\n' +
                        '  "entityTypeName" : "Flow",\n' +
                        '  "records" : [ {\n' +
                        '    "attributes" : {\n' +
                        '      "type" : "Flow",\n' +
                        '      "url" : "/services/data/v51.0/tooling/sobjects/Flow/3017Z000000pcihQAA"\n' +
                        '    },\n' +
                        '    "Id" : "3017Z000000pcihQAA",\n' +
                        '    "Definition" : {\n' +
                        '      "attributes" : {\n' +
                        '        "type" : "FlowDefinition",\n' +
                        '        "url" : "/services/data/v51.0/tooling/sobjects/FlowDefinition/3007Z000000LCODQA4"\n' +
                        '      },\n' +
                        '      "DeveloperName" : "Account"\n' +
                        '    },\n' +
                        '    "Status" : "Obsolete"\n' +
                        '  } ]\n' +
                        '}',
                null);

        SingleRequestMock pbMock1 = new SingleRequestMock(200,
                'Complete',
                '{\n' +
                        '  "attributes" : {\n' +
                        '    "type" : "Flow",\n' +
                        '    "url" : "/services/data/v51.0/tooling/sobjects/Flow/3017Z000000pcihQAA"\n' +
                        '  },\n' +
                        '  "Id" : "3017Z000000pcihQAA",\n' +
                        '  "DefinitionId" : "3007Z000000LCODQA4",\n' +
                        '  "MasterLabel" : "Account",\n' +
                        '  "ManageableState" : "unmanaged",\n' +
                        '  "VersionNumber" : 1,\n' +
                        '  "Status" : "Obsolete",\n' +
                        '  "Description" : null,\n' +
                        '  "ProcessType" : "Workflow",\n' +
                        '  "CreatedDate" : "2021-11-15T10:12:30.000+0000",\n' +
                        '  "CreatedById" : "00509000008deYLAAY",\n' +
                        '  "LastModifiedDate" : "2021-11-15T10:12:34.000+0000",\n' +
                        '  "LastModifiedById" : "00509000008deYLAAY",\n' +
                        '  "Metadata" : {\n' +
                        '    "actionCalls" : [ ],\n' +
                        '    "apexPluginCalls" : [ ],\n' +
                        '    "apiVersion" : 53.0,\n' +
                        '    "assignments" : [ ],\n' +
                        '    "choices" : [ ],\n' +
                        '    "collectionProcessors" : [ ],\n' +
                        '    "constants" : [ ],\n' +
                        '    "decisions" : [ {\n' +
                        '      "defaultConnector" : null,\n' +
                        '      "defaultConnectorLabel" : "default",\n' +
                        '      "description" : null,\n' +
                        '      "elementSubtype" : null,\n' +
                        '      "label" : "myDecision",\n' +
                        '      "locationX" : 50,\n' +
                        '      "locationY" : 0,\n' +
                        '      "name" : "myDecision",\n' +
                        '      "processMetadataValues" : [ {\n' +
                        '        "name" : "index",\n' +
                        '        "value" : {\n' +
                        '          "booleanValue" : null,\n' +
                        '          "dateTimeValue" : null,\n' +
                        '          "dateValue" : null,\n' +
                        '          "elementReference" : null,\n' +
                        '          "numberValue" : 0.0,\n' +
                        '          "stringValue" : null\n' +
                        '        }\n' +
                        '      } ],\n' +
                        '      "rules" : [ {\n' +
                        '        "conditionLogic" : "and",\n' +
                        '        "conditions" : [ {\n' +
                        '          "leftValueReference" : "myVariable_current.Name",\n' +
                        '          "operator" : "EqualTo",\n' +
                        '          "processMetadataValues" : [ {\n' +
                        '            "name" : "inputDataType",\n' +
                        '            "value" : {\n' +
                        '              "booleanValue" : null,\n' +
                        '              "dateTimeValue" : null,\n' +
                        '              "dateValue" : null,\n' +
                        '              "elementReference" : null,\n' +
                        '              "numberValue" : null,\n' +
                        '              "stringValue" : "String"\n' +
                        '            }\n' +
                        '          }, {\n' +
                        '            "name" : "leftHandSideType",\n' +
                        '            "value" : {\n' +
                        '              "booleanValue" : null,\n' +
                        '              "dateTimeValue" : null,\n' +
                        '              "dateValue" : null,\n' +
                        '              "elementReference" : null,\n' +
                        '              "numberValue" : null,\n' +
                        '              "stringValue" : "String"\n' +
                        '            }\n' +
                        '          }, {\n' +
                        '            "name" : "operatorDataType",\n' +
                        '            "value" : {\n' +
                        '              "booleanValue" : null,\n' +
                        '              "dateTimeValue" : null,\n' +
                        '              "dateValue" : null,\n' +
                        '              "elementReference" : null,\n' +
                        '              "numberValue" : null,\n' +
                        '              "stringValue" : "String"\n' +
                        '            }\n' +
                        '          }, {\n' +
                        '            "name" : "rightHandSideType",\n' +
                        '            "value" : {\n' +
                        '              "booleanValue" : null,\n' +
                        '              "dateTimeValue" : null,\n' +
                        '              "dateValue" : null,\n' +
                        '              "elementReference" : null,\n' +
                        '              "numberValue" : null,\n' +
                        '              "stringValue" : "String"\n' +
                        '            }\n' +
                        '          } ],\n' +
                        '          "rightValue" : {\n' +
                        '            "booleanValue" : null,\n' +
                        '            "dateTimeValue" : null,\n' +
                        '            "dateValue" : null,\n' +
                        '            "elementReference" : null,\n' +
                        '            "numberValue" : null,\n' +
                        '            "stringValue" : "Test"\n' +
                        '          }\n' +
                        '        } ],\n' +
                        '        "connector" : {\n' +
                        '          "processMetadataValues" : [ ],\n' +
                        '          "targetReference" : "myRule_1_A1"\n' +
                        '        },\n' +
                        '        "description" : null,\n' +
                        '        "doesRequireRecordChangedToMeetCriteria" : null,\n' +
                        '        "label" : "Update",\n' +
                        '        "name" : "myRule_1",\n' +
                        '        "processMetadataValues" : [ ]\n' +
                        '      } ]\n' +
                        '    } ],\n' +
                        '    "description" : null,\n' +
                        '    "dynamicChoiceSets" : [ ],\n' +
                        '    "formulas" : [ ],\n' +
                        '    "interviewLabel" : "Account-1_InterviewLabel",\n' +
                        '    "isAdditionalPermissionRequiredToRun" : null,\n' +
                        '    "isTemplate" : null,\n' +
                        '    "label" : "Account",\n' +
                        '    "loops" : [ ],\n' +
                        '    "orchestratedStages" : [ ],\n' +
                        '    "processMetadataValues" : [ {\n' +
                        '      "name" : "ObjectType",\n' +
                        '      "value" : {\n' +
                        '        "booleanValue" : null,\n' +
                        '        "dateTimeValue" : null,\n' +
                        '        "dateValue" : null,\n' +
                        '        "elementReference" : null,\n' +
                        '        "numberValue" : null,\n' +
                        '        "stringValue" : "Account"\n' +
                        '      }\n' +
                        '    }, {\n' +
                        '      "name" : "ObjectVariable",\n' +
                        '      "value" : {\n' +
                        '        "booleanValue" : null,\n' +
                        '        "dateTimeValue" : null,\n' +
                        '        "dateValue" : null,\n' +
                        '        "elementReference" : "myVariable_current",\n' +
                        '        "numberValue" : null,\n' +
                        '        "stringValue" : null\n' +
                        '      }\n' +
                        '    }, {\n' +
                        '      "name" : "OldObjectVariable",\n' +
                        '      "value" : {\n' +
                        '        "booleanValue" : null,\n' +
                        '        "dateTimeValue" : null,\n' +
                        '        "dateValue" : null,\n' +
                        '        "elementReference" : "myVariable_old",\n' +
                        '        "numberValue" : null,\n' +
                        '        "stringValue" : null\n' +
                        '      }\n' +
                        '    }, {\n' +
                        '      "name" : "TriggerType",\n' +
                        '      "value" : {\n' +
                        '        "booleanValue" : null,\n' +
                        '        "dateTimeValue" : null,\n' +
                        '        "dateValue" : null,\n' +
                        '        "elementReference" : null,\n' +
                        '        "numberValue" : null,\n' +
                        '        "stringValue" : "onCreateOnly"\n' +
                        '      }\n' +
                        '    } ],\n' +
                        '    "processType" : "Workflow",\n' +
                        '    "recordCreates" : [ ],\n' +
                        '    "recordDeletes" : [ ],\n' +
                        '    "recordLookups" : [ ],\n' +
                        '    "recordUpdates" : [ {\n' +
                        '      "connector" : null,\n' +
                        '      "description" : null,\n' +
                        '      "elementSubtype" : null,\n' +
                        '      "faultConnector" : null,\n' +
                        '      "filterLogic" : "and",\n' +
                        '      "filters" : [ {\n' +
                        '        "field" : "Id",\n' +
                        '        "operator" : "EqualTo",\n' +
                        '        "processMetadataValues" : [ {\n' +
                        '          "name" : "implicit",\n' +
                        '          "value" : {\n' +
                        '            "booleanValue" : true,\n' +
                        '            "dateTimeValue" : null,\n' +
                        '            "dateValue" : null,\n' +
                        '            "elementReference" : null,\n' +
                        '            "numberValue" : null,\n' +
                        '            "stringValue" : null\n' +
                        '          }\n' +
                        '        } ],\n' +
                        '        "value" : {\n' +
                        '          "booleanValue" : null,\n' +
                        '          "dateTimeValue" : null,\n' +
                        '          "dateValue" : null,\n' +
                        '          "elementReference" : "myVariable_current.Id",\n' +
                        '          "numberValue" : null,\n' +
                        '          "stringValue" : null\n' +
                        '        }\n' +
                        '      } ],\n' +
                        '      "inputAssignments" : [ {\n' +
                        '        "field" : "Name",\n' +
                        '        "processMetadataValues" : [ {\n' +
                        '          "name" : "dataType",\n' +
                        '          "value" : {\n' +
                        '            "booleanValue" : null,\n' +
                        '            "dateTimeValue" : null,\n' +
                        '            "dateValue" : null,\n' +
                        '            "elementReference" : null,\n' +
                        '            "numberValue" : null,\n' +
                        '            "stringValue" : "String"\n' +
                        '          }\n' +
                        '        }, {\n' +
                        '          "name" : "isRequired",\n' +
                        '          "value" : {\n' +
                        '            "booleanValue" : false,\n' +
                        '            "dateTimeValue" : null,\n' +
                        '            "dateValue" : null,\n' +
                        '            "elementReference" : null,\n' +
                        '            "numberValue" : null,\n' +
                        '            "stringValue" : null\n' +
                        '          }\n' +
                        '        }, {\n' +
                        '          "name" : "leftHandSideLabel",\n' +
                        '          "value" : {\n' +
                        '            "booleanValue" : null,\n' +
                        '            "dateTimeValue" : null,\n' +
                        '            "dateValue" : null,\n' +
                        '            "elementReference" : null,\n' +
                        '            "numberValue" : null,\n' +
                        '            "stringValue" : "Account Name"\n' +
                        '          }\n' +
                        '        }, {\n' +
                        '          "name" : "leftHandSideReferenceTo",\n' +
                        '          "value" : {\n' +
                        '            "booleanValue" : null,\n' +
                        '            "dateTimeValue" : null,\n' +
                        '            "dateValue" : null,\n' +
                        '            "elementReference" : null,\n' +
                        '            "numberValue" : null,\n' +
                        '            "stringValue" : ""\n' +
                        '          }\n' +
                        '        }, {\n' +
                        '          "name" : "rightHandSideType",\n' +
                        '          "value" : {\n' +
                        '            "booleanValue" : null,\n' +
                        '            "dateTimeValue" : null,\n' +
                        '            "dateValue" : null,\n' +
                        '            "elementReference" : null,\n' +
                        '            "numberValue" : null,\n' +
                        '            "stringValue" : "String"\n' +
                        '          }\n' +
                        '        } ],\n' +
                        '        "value" : {\n' +
                        '          "booleanValue" : null,\n' +
                        '          "dateTimeValue" : null,\n' +
                        '          "dateValue" : null,\n' +
                        '          "elementReference" : null,\n' +
                        '          "numberValue" : null,\n' +
                        '          "stringValue" : "test21"\n' +
                        '        }\n' +
                        '      } ],\n' +
                        '      "inputReference" : null,\n' +
                        '      "label" : "test",\n' +
                        '      "locationX" : 100,\n' +
                        '      "locationY" : 200,\n' +
                        '      "name" : "myRule_1_A1",\n' +
                        '      "object" : "Account",\n' +
                        '      "processMetadataValues" : [ {\n' +
                        '        "name" : "evaluationType",\n' +
                        '        "value" : {\n' +
                        '          "booleanValue" : null,\n' +
                        '          "dateTimeValue" : null,\n' +
                        '          "dateValue" : null,\n' +
                        '          "elementReference" : null,\n' +
                        '          "numberValue" : null,\n' +
                        '          "stringValue" : "always"\n' +
                        '        }\n' +
                        '      }, {\n' +
                        '        "name" : "extraTypeInfo",\n' +
                        '        "value" : null\n' +
                        '      }, {\n' +
                        '        "name" : "isChildRelationship",\n' +
                        '        "value" : {\n' +
                        '          "booleanValue" : false,\n' +
                        '          "dateTimeValue" : null,\n' +
                        '          "dateValue" : null,\n' +
                        '          "elementReference" : null,\n' +
                        '          "numberValue" : null,\n' +
                        '          "stringValue" : null\n' +
                        '        }\n' +
                        '      }, {\n' +
                        '        "name" : "reference",\n' +
                        '        "value" : {\n' +
                        '          "booleanValue" : null,\n' +
                        '          "dateTimeValue" : null,\n' +
                        '          "dateValue" : null,\n' +
                        '          "elementReference" : null,\n' +
                        '          "numberValue" : null,\n' +
                        '          "stringValue" : "[Account]"\n' +
                        '        }\n' +
                        '      }, {\n' +
                        '        "name" : "referenceTargetField",\n' +
                        '        "value" : null\n' +
                        '      } ]\n' +
                        '    } ],\n' +
                        '    "runInMode" : null,\n' +
                        '    "screens" : [ ],\n' +
                        '    "start" : null,\n' +
                        '    "startElementReference" : "myDecision",\n' +
                        '    "status" : "Obsolete",\n' +
                        '    "steps" : [ ],\n' +
                        '    "subflows" : [ ],\n' +
                        '    "textTemplates" : [ ],\n' +
                        '    "urls" : null,\n' +
                        '    "variables" : [ {\n' +
                        '      "apexClass" : null,\n' +
                        '      "dataType" : "SObject",\n' +
                        '      "description" : null,\n' +
                        '      "isCollection" : false,\n' +
                        '      "isInput" : true,\n' +
                        '      "isOutput" : true,\n' +
                        '      "name" : "myVariable_current",\n' +
                        '      "objectType" : "Account",\n' +
                        '      "processMetadataValues" : [ ],\n' +
                        '      "scale" : null,\n' +
                        '      "value" : null\n' +
                        '    }, {\n' +
                        '      "apexClass" : null,\n' +
                        '      "dataType" : "SObject",\n' +
                        '      "description" : null,\n' +
                        '      "isCollection" : false,\n' +
                        '      "isInput" : true,\n' +
                        '      "isOutput" : false,\n' +
                        '      "name" : "myVariable_old",\n' +
                        '      "objectType" : "Account",\n' +
                        '      "processMetadataValues" : [ ],\n' +
                        '      "scale" : null,\n' +
                        '      "value" : null\n' +
                        '    } ],\n' +
                        '    "waits" : [ ]\n' +
                        '  },\n' +
                        '  "FullName" : "Account-1",\n' +
                        '  "IsTemplate" : false,\n' +
                        '  "RunInMode" : null,\n' +
                        '  "ApiVersion" : 53.0\n' +
                        '}',
                null);

        SingleRequestMock pbMock2 = new SingleRequestMock(200,
                'Complete',
                '{\n' +
                        '  "attributes" : {\n' +
                        '    "type" : "Flow",\n' +
                        '    "url" : "/services/data/v51.0/tooling/sobjects/Flow/3017Z000000pcihQAA"\n' +
                        '  },\n' +
                        '  "Id" : "3017Z000000pcihQAA",\n' +
                        '  "DefinitionId" : "3007Z000000LCODQA4",\n' +
                        '  "MasterLabel" : "Account",\n' +
                        '  "ManageableState" : "unmanaged",\n' +
                        '  "VersionNumber" : 1,\n' +
                        '  "Status" : "Obsolete",\n' +
                        '  "Description" : null,\n' +
                        '  "ProcessType" : "Workflow",\n' +
                        '  "CreatedDate" : "2021-11-15T10:12:30.000+0000",\n' +
                        '  "CreatedById" : "00509000008deYLAAY",\n' +
                        '  "LastModifiedDate" : "2021-11-15T10:12:34.000+0000",\n' +
                        '  "LastModifiedById" : "00509000008deYLAAY",\n' +
                        '  "Metadata" : {\n' +
                        '    "actionCalls" : [ ],\n' +
                        '    "apexPluginCalls" : [ ],\n' +
                        '    "apiVersion" : 53.0,\n' +
                        '    "assignments" : [ ],\n' +
                        '    "choices" : [ ],\n' +
                        '    "collectionProcessors" : [ ],\n' +
                        '    "constants" : [ ],\n' +
                        '    "decisions" : [ {\n' +
                        '      "defaultConnector" : null,\n' +
                        '      "defaultConnectorLabel" : "default",\n' +
                        '      "description" : null,\n' +
                        '      "elementSubtype" : null,\n' +
                        '      "label" : "myDecision",\n' +
                        '      "locationX" : 50,\n' +
                        '      "locationY" : 0,\n' +
                        '      "name" : "myDecision",\n' +
                        '      "processMetadataValues" : [ {\n' +
                        '        "name" : "index",\n' +
                        '        "value" : {\n' +
                        '          "booleanValue" : null,\n' +
                        '          "dateTimeValue" : null,\n' +
                        '          "dateValue" : null,\n' +
                        '          "elementReference" : null,\n' +
                        '          "numberValue" : 0.0,\n' +
                        '          "stringValue" : null\n' +
                        '        }\n' +
                        '      } ],\n' +
                        '      "rules" : [ {\n' +
                        '        "conditionLogic" : "and",\n' +
                        '        "conditions" : [ {\n' +
                        '          "leftValueReference" : "myVariable_current.Name",\n' +
                        '          "operator" : "EqualTo",\n' +
                        '          "processMetadataValues" : [ {\n' +
                        '            "name" : "inputDataType",\n' +
                        '            "value" : {\n' +
                        '              "booleanValue" : null,\n' +
                        '              "dateTimeValue" : null,\n' +
                        '              "dateValue" : null,\n' +
                        '              "elementReference" : null,\n' +
                        '              "numberValue" : null,\n' +
                        '              "stringValue" : "String"\n' +
                        '            }\n' +
                        '          }, {\n' +
                        '            "name" : "leftHandSideType",\n' +
                        '            "value" : {\n' +
                        '              "booleanValue" : null,\n' +
                        '              "dateTimeValue" : null,\n' +
                        '              "dateValue" : null,\n' +
                        '              "elementReference" : null,\n' +
                        '              "numberValue" : null,\n' +
                        '              "stringValue" : "String"\n' +
                        '            }\n' +
                        '          }, {\n' +
                        '            "name" : "operatorDataType",\n' +
                        '            "value" : {\n' +
                        '              "booleanValue" : null,\n' +
                        '              "dateTimeValue" : null,\n' +
                        '              "dateValue" : null,\n' +
                        '              "elementReference" : null,\n' +
                        '              "numberValue" : null,\n' +
                        '              "stringValue" : "String"\n' +
                        '            }\n' +
                        '          }, {\n' +
                        '            "name" : "rightHandSideType",\n' +
                        '            "value" : {\n' +
                        '              "booleanValue" : null,\n' +
                        '              "dateTimeValue" : null,\n' +
                        '              "dateValue" : null,\n' +
                        '              "elementReference" : null,\n' +
                        '              "numberValue" : null,\n' +
                        '              "stringValue" : "String"\n' +
                        '            }\n' +
                        '          } ],\n' +
                        '          "rightValue" : {\n' +
                        '            "booleanValue" : null,\n' +
                        '            "dateTimeValue" : null,\n' +
                        '            "dateValue" : null,\n' +
                        '            "elementReference" : null,\n' +
                        '            "numberValue" : null,\n' +
                        '            "stringValue" : "Test"\n' +
                        '          }\n' +
                        '        } ],\n' +
                        '        "connector" : {\n' +
                        '          "processMetadataValues" : [ ],\n' +
                        '          "targetReference" : "myRule_1_A1"\n' +
                        '        },\n' +
                        '        "description" : null,\n' +
                        '        "doesRequireRecordChangedToMeetCriteria" : null,\n' +
                        '        "label" : "Update",\n' +
                        '        "name" : "myRule_1",\n' +
                        '        "processMetadataValues" : [ ]\n' +
                        '      } ]\n' +
                        '    } ],\n' +
                        '    "description" : null,\n' +
                        '    "dynamicChoiceSets" : [ ],\n' +
                        '    "formulas" : [ ],\n' +
                        '    "interviewLabel" : "Account-1_InterviewLabel",\n' +
                        '    "isAdditionalPermissionRequiredToRun" : null,\n' +
                        '    "isTemplate" : null,\n' +
                        '    "label" : "Account",\n' +
                        '    "loops" : [ ],\n' +
                        '    "orchestratedStages" : [ ],\n' +
                        '    "processMetadataValues" : [ {\n' +
                        '      "name" : "ObjectType",\n' +
                        '      "value" : {\n' +
                        '        "booleanValue" : null,\n' +
                        '        "dateTimeValue" : null,\n' +
                        '        "dateValue" : null,\n' +
                        '        "elementReference" : null,\n' +
                        '        "numberValue" : null,\n' +
                        '        "stringValue" : "Account"\n' +
                        '      }\n' +
                        '    }, {\n' +
                        '      "name" : "ObjectVariable",\n' +
                        '      "value" : {\n' +
                        '        "booleanValue" : null,\n' +
                        '        "dateTimeValue" : null,\n' +
                        '        "dateValue" : null,\n' +
                        '        "elementReference" : "myVariable_current",\n' +
                        '        "numberValue" : null,\n' +
                        '        "stringValue" : null\n' +
                        '      }\n' +
                        '    }, {\n' +
                        '      "name" : "OldObjectVariable",\n' +
                        '      "value" : {\n' +
                        '        "booleanValue" : null,\n' +
                        '        "dateTimeValue" : null,\n' +
                        '        "dateValue" : null,\n' +
                        '        "elementReference" : "myVariable_old",\n' +
                        '        "numberValue" : null,\n' +
                        '        "stringValue" : null\n' +
                        '      }\n' +
                        '    }, {\n' +
                        '      "name" : "TriggerType",\n' +
                        '      "value" : {\n' +
                        '        "booleanValue" : null,\n' +
                        '        "dateTimeValue" : null,\n' +
                        '        "dateValue" : null,\n' +
                        '        "elementReference" : null,\n' +
                        '        "numberValue" : null,\n' +
                        '        "stringValue" : "onCreateOnly"\n' +
                        '      }\n' +
                        '    } ],\n' +
                        '    "processType" : "Workflow",\n' +
                        '    "recordCreates" : [ ],\n' +
                        '    "recordDeletes" : [ ],\n' +
                        '    "recordLookups" : [ ],\n' +
                        '    "recordUpdates" : [ {\n' +
                        '      "connector" : null,\n' +
                        '      "description" : null,\n' +
                        '      "elementSubtype" : null,\n' +
                        '      "faultConnector" : null,\n' +
                        '      "filterLogic" : "and",\n' +
                        '      "filters" : [ {\n' +
                        '        "field" : "Id",\n' +
                        '        "operator" : "EqualTo",\n' +
                        '        "processMetadataValues" : [ {\n' +
                        '          "name" : "implicit",\n' +
                        '          "value" : {\n' +
                        '            "booleanValue" : true,\n' +
                        '            "dateTimeValue" : null,\n' +
                        '            "dateValue" : null,\n' +
                        '            "elementReference" : null,\n' +
                        '            "numberValue" : null,\n' +
                        '            "stringValue" : null\n' +
                        '          }\n' +
                        '        } ],\n' +
                        '        "value" : {\n' +
                        '          "booleanValue" : null,\n' +
                        '          "dateTimeValue" : null,\n' +
                        '          "dateValue" : null,\n' +
                        '          "elementReference" : "myVariable_current.Id",\n' +
                        '          "numberValue" : null,\n' +
                        '          "stringValue" : null\n' +
                        '        }\n' +
                        '      } ],\n' +
                        '      "inputAssignments" : [ {\n' +
                        '        "field" : "Name",\n' +
                        '        "processMetadataValues" : [ {\n' +
                        '          "name" : "dataType",\n' +
                        '          "value" : {\n' +
                        '            "booleanValue" : null,\n' +
                        '            "dateTimeValue" : null,\n' +
                        '            "dateValue" : null,\n' +
                        '            "elementReference" : null,\n' +
                        '            "numberValue" : null,\n' +
                        '            "stringValue" : "String"\n' +
                        '          }\n' +
                        '        }, {\n' +
                        '          "name" : "isRequired",\n' +
                        '          "value" : {\n' +
                        '            "booleanValue" : false,\n' +
                        '            "dateTimeValue" : null,\n' +
                        '            "dateValue" : null,\n' +
                        '            "elementReference" : null,\n' +
                        '            "numberValue" : null,\n' +
                        '            "stringValue" : null\n' +
                        '          }\n' +
                        '        }, {\n' +
                        '          "name" : "leftHandSideLabel",\n' +
                        '          "value" : {\n' +
                        '            "booleanValue" : null,\n' +
                        '            "dateTimeValue" : null,\n' +
                        '            "dateValue" : null,\n' +
                        '            "elementReference" : null,\n' +
                        '            "numberValue" : null,\n' +
                        '            "stringValue" : "Account Name"\n' +
                        '          }\n' +
                        '        }, {\n' +
                        '          "name" : "leftHandSideReferenceTo",\n' +
                        '          "value" : {\n' +
                        '            "booleanValue" : null,\n' +
                        '            "dateTimeValue" : null,\n' +
                        '            "dateValue" : null,\n' +
                        '            "elementReference" : null,\n' +
                        '            "numberValue" : null,\n' +
                        '            "stringValue" : ""\n' +
                        '          }\n' +
                        '        }, {\n' +
                        '          "name" : "rightHandSideType",\n' +
                        '          "value" : {\n' +
                        '            "booleanValue" : null,\n' +
                        '            "dateTimeValue" : null,\n' +
                        '            "dateValue" : null,\n' +
                        '            "elementReference" : null,\n' +
                        '            "numberValue" : null,\n' +
                        '            "stringValue" : "String"\n' +
                        '          }\n' +
                        '        } ],\n' +
                        '        "value" : {\n' +
                        '          "booleanValue" : null,\n' +
                        '          "dateTimeValue" : null,\n' +
                        '          "dateValue" : null,\n' +
                        '          "elementReference" : null,\n' +
                        '          "numberValue" : null,\n' +
                        '          "stringValue" : "test21"\n' +
                        '        }\n' +
                        '      } ],\n' +
                        '      "inputReference" : null,\n' +
                        '      "label" : "test",\n' +
                        '      "locationX" : 100,\n' +
                        '      "locationY" : 200,\n' +
                        '      "name" : "myRule_1_A1",\n' +
                        '      "object" : "Account",\n' +
                        '      "processMetadataValues" : [ {\n' +
                        '        "name" : "evaluationType",\n' +
                        '        "value" : {\n' +
                        '          "booleanValue" : null,\n' +
                        '          "dateTimeValue" : null,\n' +
                        '          "dateValue" : null,\n' +
                        '          "elementReference" : null,\n' +
                        '          "numberValue" : null,\n' +
                        '          "stringValue" : "always"\n' +
                        '        }\n' +
                        '      }, {\n' +
                        '        "name" : "extraTypeInfo",\n' +
                        '        "value" : null\n' +
                        '      }, {\n' +
                        '        "name" : "isChildRelationship",\n' +
                        '        "value" : {\n' +
                        '          "booleanValue" : false,\n' +
                        '          "dateTimeValue" : null,\n' +
                        '          "dateValue" : null,\n' +
                        '          "elementReference" : null,\n' +
                        '          "numberValue" : null,\n' +
                        '          "stringValue" : null\n' +
                        '        }\n' +
                        '      }, {\n' +
                        '        "name" : "reference",\n' +
                        '        "value" : {\n' +
                        '          "booleanValue" : null,\n' +
                        '          "dateTimeValue" : null,\n' +
                        '          "dateValue" : null,\n' +
                        '          "elementReference" : null,\n' +
                        '          "numberValue" : null,\n' +
                        '          "stringValue" : "[Account]"\n' +
                        '        }\n' +
                        '      }, {\n' +
                        '        "name" : "referenceTargetField",\n' +
                        '        "value" : null\n' +
                        '      } ]\n' +
                        '    } ],\n' +
                        '    "runInMode" : null,\n' +
                        '    "screens" : [ ],\n' +
                        '    "start" : null,\n' +
                        '    "startElementReference" : "myDecision",\n' +
                        '    "status" : "Obsolete",\n' +
                        '    "steps" : [ ],\n' +
                        '    "subflows" : [ ],\n' +
                        '    "textTemplates" : [ ],\n' +
                        '    "urls" : null,\n' +
                        '    "variables" : [ {\n' +
                        '      "apexClass" : null,\n' +
                        '      "dataType" : "SObject",\n' +
                        '      "description" : null,\n' +
                        '      "isCollection" : false,\n' +
                        '      "isInput" : true,\n' +
                        '      "isOutput" : true,\n' +
                        '      "name" : "myVariable_current",\n' +
                        '      "objectType" : "Account",\n' +
                        '      "processMetadataValues" : [ ],\n' +
                        '      "scale" : null,\n' +
                        '      "value" : null\n' +
                        '    }, {\n' +
                        '      "apexClass" : null,\n' +
                        '      "dataType" : "SObject",\n' +
                        '      "description" : null,\n' +
                        '      "isCollection" : false,\n' +
                        '      "isInput" : true,\n' +
                        '      "isOutput" : false,\n' +
                        '      "name" : "myVariable_old",\n' +
                        '      "objectType" : "Account",\n' +
                        '      "processMetadataValues" : [ ],\n' +
                        '      "scale" : null,\n' +
                        '      "value" : null\n' +
                        '    } ],\n' +
                        '    "waits" : [ ]\n' +
                        '  },\n' +
                        '  "FullName" : "Account-1",\n' +
                        '  "IsTemplate" : false,\n' +
                        '  "RunInMode" : null,\n' +
                        '  "ApiVersion" : 53.0\n' +
                        '}',
                null);



        Map<String, HttpCalloutMock> endpoint2TestResp = new Map<String,HttpCalloutMock>();
        endpoint2TestResp.put('callout:UpeoOptimizer/services/data/v51.0/tooling/query?q=SELECT+Definition.DeveloperName,count(Status)+FROM+Flow+WHERE+ProcessType=\'Workflow\'+Group+by+Definition.DeveloperName',pbBaseCall);
        endpoint2TestResp.put('callout:UpeoOptimizer/services/data/v51.0/tooling/query?q=SELECT+Id,Definition.DeveloperName,Status+FROM+Flow+WHERE+ProcessType=\'Workflow\'+AND+Status=\'Active\'',pbActiveCall);
        endpoint2TestResp.put('callout:UpeoOptimizer/services/data/v51.0/tooling/query?q=SELECT+Id,Definition.DeveloperName,Status+FROM+Flow+WHERE+ProcessType=\'Workflow\'+AND+Status!=\'Active\'+Order+By+LastModifiedDate+DESC',pbInactiveCall);
        endpoint2TestResp.put('callout:UpeoOptimizer/services/data/v43.0/tooling/sobjects/Flow/3017Z000000pdWwQAI', pbMock1);
        endpoint2TestResp.put('callout:UpeoOptimizer/services/data/v43.0/tooling/sobjects/Flow/3017Z000000pcihQAA', pbMock2);

        HttpCalloutMock multiCalloutMock = new MultiRequestMock(endpoint2TestResp);
        Test.setMock(HttpCalloutMock.class, multiCalloutMock);

        UpeoAnalyzerBatchProcessBuilder job = new UpeoAnalyzerBatchProcessBuilder();
        DataBase.executeBatch(job);

        test.stopTest();


    }
}