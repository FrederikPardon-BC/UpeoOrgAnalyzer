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
private class UpeoAnalyzerWfrBasicTest {

    @IsTest
    static void testParse() {
        String json=		'{'+
                '  "size" : 5,'+
                '  "totalSize" : 5,'+
                '  "done" : true,'+
                '  "queryLocator" : null,'+
                '  "entityTypeName" : "WorkflowRule",'+
                '  "records" : [ {'+
                '    "attributes" : {'+
                '      "type" : "WorkflowRule",'+
                '      "url" : "/services/data/v47.0/tooling/sobjects/WorkflowRule/01Q090000001sk8EAA"'+
                '    },'+
                '    "Id" : "01Q090000001sk8EAA",'+
                '    "Name" : "New Service Order - Must be Draft Status",'+
                '    "TableEnumOrId" : "CHANNEL_ORDERS__Service_Order__c"'+
                '  }, {'+
                '    "attributes" : {'+
                '      "type" : "WorkflowRule",'+
                '      "url" : "/services/data/v47.0/tooling/sobjects/WorkflowRule/01Q090000001sk7EAA"'+
                '    },'+
                '    "Id" : "01Q090000001sk7EAA",'+
                '    "Name" : "Service Order Date Received",'+
                '    "TableEnumOrId" : "CHANNEL_ORDERS__Service_Order__c"'+
                '  }, {'+
                '    "attributes" : {'+
                '      "type" : "WorkflowRule",'+
                '      "url" : "/services/data/v47.0/tooling/sobjects/WorkflowRule/01Q090000001sk9EAA"'+
                '    },'+
                '    "Id" : "01Q090000001sk9EAA",'+
                '    "Name" : "Partner Contract Term External ID",'+
                '    "TableEnumOrId" : "CHANNEL_ORDERS__Partner_Contract_Terms__c"'+
                '  }, {'+
                '    "attributes" : {'+
                '      "type" : "WorkflowRule",'+
                '      "url" : "/services/data/v47.0/tooling/sobjects/WorkflowRule/01Q090000001skBEAQ"'+
                '    },'+
                '    "Id" : "01Q090000001skBEAQ",'+
                '    "Name" : "Populate License Fields",'+
                '    "TableEnumOrId" : "sfcma__Subscription__c"'+
                '  }, {'+
                '    "attributes" : {'+
                '      "type" : "WorkflowRule",'+
                '      "url" : "/services/data/v47.0/tooling/sobjects/WorkflowRule/01Q090000001skAEAQ"'+
                '    },'+
                '    "Id" : "01Q090000001skAEAQ",'+
                '    "Name" : "Populate Pricing fields",'+
                '    "TableEnumOrId" : "CHANNEL_ORDERS__Service_Order_Detail__c"'+
                '  } ]'+
                '}';
        UpeoAnalyzerWfrBasic obj = UpeoAnalyzerWfrBasic.parse(json);
        System.assert(obj != null);
    }
}