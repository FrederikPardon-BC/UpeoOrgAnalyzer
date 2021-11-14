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
private class UpeoAnalyzerValidationRuleMetricsTest {
    @IsTest
    static void fetchActiveValidationDataTest() {
        List<SObject> objRecords = UpeoAnalyzerValidationRuleMetricsCtrl.fetchActiveValidationData();
    }

    @IsTest
    static void fetchInactiveValidationDataTest() {
        List<SObject> objRecords = UpeoAnalyzerValidationRuleMetricsCtrl.fetchInactiveValidationData();
    }

    @IsTest
    static void validationMetricsTest() {

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

        UpeoAnalyzerValidationRuleMetricsCtrl.validationMetrics();
    }

}