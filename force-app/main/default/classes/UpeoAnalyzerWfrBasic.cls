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
public class UpeoAnalyzerWfrBasic {
    public Integer size;    //5
    public Integer totalSize;    //5
    public boolean done;
    public cls_queryLocator queryLocator;
    public String entityTypeName;    //WorkflowRule
    public cls_records[] records;
    class cls_queryLocator {
    }
    public class cls_records {
        public cls_attributes attributes;
        public String Id;    //01Q090000001sk8EAA
        public String Name;    //New Service Order - Must be Draft Status
        public String TableEnumOrId;    //CHANNEL_ORDERS__Service_Order__c
    }
    public class cls_attributes {
        public String type;    //WorkflowRule
        public String url;    ///services/data/v47.0/tooling/sobjects/WorkflowRule/01Q090000001sk8EAA
    }
    public static UpeoAnalyzerWfrBasic parse(String json) {
        return (UpeoAnalyzerWfrBasic) System.JSON.deserialize(json, UpeoAnalyzerWfrBasic.class);
    }
}