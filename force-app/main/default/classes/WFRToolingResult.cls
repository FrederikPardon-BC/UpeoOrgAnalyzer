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
public class WFRToolingResult{
    public cls_attributes attributes;
    public String Id;	//01Q090000001sk8EAA
    public String Name;	//New Service Order - Must be Draft Status
    public String TableEnumOrId;	//CHANNEL_ORDERS__Service_Order__c
    public String ManageableState;	//installed
    public String NamespacePrefix;	//CHANNEL_ORDERS
    public String CreatedDate;	//2021-08-05T12:47:36.000+0000
    public String CreatedById;	//00509000008deYLAAY
    public String LastModifiedDate;	//2021-08-05T12:47:36.000+0000
    public String LastModifiedById;	//00509000008deYLAAY
    public cls_Metadata Metadata;
    public Boolean Active;
    public String FullName;	//CHANNEL_ORDERS__Service_Order__c.CHANNEL_ORDERS__New Service Order - Must be Draft Status
    class cls_attributes {
        public String type;	//WorkflowRule
        public String url;	///services/data/v47.0/tooling/sobjects/WorkflowRule/01Q090000001sk8EAA
    }
    public class cls_Metadata {
        public cls_actions[] actions;
        //public cls_booleanFilter booleanFilter;
        public cls_criteriaItems[] criteriaItems;
        public cls_urls urls;
        public cls_workflowTimeTriggers[] workflowTimeTriggers;
        public boolean active;
        //public cls_description description;
        public String triggerType;	//onCreateOnly
    }
    class cls_actions {
        public String name;	//CHANNEL_ORDERS__New_Service_Order_Must_be_Draft_Status
        public String type;	//FieldUpdate
    }
    class cls_booleanFilter {
    }
    class cls_criteriaItems {
        public String field;	//CHANNEL_ORDERS__Service_Order__c.CHANNEL_ORDERS__Service_Order_Status__c
        public String operation;	//notEqual
        public String value;	//Draft
        public cls_valueField valueField;
    }
    class cls_valueField {
    }
    class cls_urls {
    }
    class cls_workflowTimeTriggers {
    }
    class cls_description {
    }
    public static WFRToolingResult parse(String json){
        return (WFRToolingResult) System.JSON.deserialize(json, WFRToolingResult.class);
    }
}