/**
 * Created by fpardon on 15/11/2021.
 */

public class UpeoAnalyzerPBDetailWrapper{
    public cls_attributes attributes;
    public String Id;	//301090000005whQAAQ
    public String DefinitionId;	//300090000009ZwWAAU
    public String MasterLabel;	//Lead Insert/Update
    public String ManageableState;	//unmanaged
    public Integer VersionNumber;	//1
    public String Status;	//Active
    public cls_Description Description;
    public String ProcessType;	//Workflow
    public String CreatedDate;	//2021-08-27T13:31:48.000+0000
    public String CreatedById;	//00509000007iKmCAAU
    public String LastModifiedDate;	//2021-08-27T13:31:52.000+0000
    public String LastModifiedById;	//00509000007iKmCAAU
    public cls_Metadata Metadata;
    public String FullName;	//Lead_Insert_Update-1
    class cls_attributes {
        public String type;	//Flow
        public String url;	///services/data/v43.0/tooling/sobjects/Flow/301090000005whQAAQ
    }
    class cls_Description {
    }
    public class cls_Metadata {
        public cls_actionCalls[] actionCalls;
        public cls_apexPluginCalls[] apexPluginCalls;
        public cls_assignments[] assignments;
        public cls_choices[] choices;
        public cls_constants[] constants;
        public cls_decisions[] decisions;
        public cls_description description;
        public cls_dynamicChoiceSets[] dynamicChoiceSets;
        public cls_formulas[] formulas;
        public String interviewLabel;	//Lead_Insert_Update-1_InterviewLabel
        public String label;	//Lead Insert/Update
        public cls_loops[] loops;
        public cls_processMetadataValues[] processMetadataValues;
        public String processType;	//Workflow
        public cls_recordCreates[] recordCreates;
        public cls_recordDeletes[] recordDeletes;
        public cls_recordLookups[] recordLookups;
        public cls_recordUpdates[] recordUpdates;
        public cls_screens[] screens;
        public String startElementReference;	//myDecision
        public cls_steps[] steps;
        public cls_subflows[] subflows;
        public cls_textTemplates[] textTemplates;
        public cls_urls urls;
        public cls_variables[] variables;
        public cls_waits[] waits;
    }
    class cls_actionCalls {
        public String actionName;	//Lead.New_Lead_from_Website
        public String actionType;	//emailAlert
        public cls_connector connector;
        public cls_description description;
        public cls_elementSubtype elementSubtype;
        public cls_faultConnector faultConnector;
        public cls_inputParameters[] inputParameters;
        public String label;	//Send Email
        public Integer locationX;	//100
        public Integer locationY;	//200
        public String name;	//myRule_1_A1
        public cls_outputParameters[] outputParameters;
        public cls_processMetadataValues[] processMetadataValues;
    }
    class cls_connector {
        public cls_processMetadataValues[] processMetadataValues;
        public String targetReference;	//myRule_1_A1
    }
    class cls_description {
    }
    class cls_elementSubtype {
    }
    class cls_faultConnector {
    }
    class cls_inputParameters {
        public String name;	//SObjectRowId
        public cls_processMetadataValues[] processMetadataValues;
        public cls_value value;
    }
    class cls_processMetadataValues {
    }
    class cls_value {
    }
    class cls_booleanValue {
    }
    class cls_dateTimeValue {
    }
    class cls_dateValue {
    }
    class cls_numberValue {
    }
    class cls_stringValue {
    }
    class cls_outputParameters {
    }
    class cls_elementReference {
    }
    class cls_apexPluginCalls {
    }
    class cls_assignments {
    }
    class cls_choices {
    }
    class cls_constants {
    }
    class cls_decisions {
        public cls_defaultConnector defaultConnector;
        public String defaultConnectorLabel;	//default
        public cls_description description;
        public cls_elementSubtype elementSubtype;
        public String label;	//myDecision
        public Integer locationX;	//50
        public Integer locationY;	//0
        public String name;	//myDecision
        public cls_processMetadataValues[] processMetadataValues;
        public cls_rules[] rules;
    }
    class cls_defaultConnector {
    }
    class cls_rules {
        public String conditionLogic;	//and
        public cls_conditions[] conditions;
        public cls_connector connector;
        public cls_description description;
        public String label;	//Lead Created from Website
        public String name;	//myRule_1
        public cls_processMetadataValues[] processMetadataValues;
    }
    class cls_conditions {
        public String leftValueReference;	//formula_myRule_1
        public String operator;	//EqualTo
        public cls_processMetadataValues[] processMetadataValues;
        public cls_rightValue rightValue;
    }
    class cls_rightValue {
        public boolean booleanValue;
        public cls_dateTimeValue dateTimeValue;
        public cls_dateValue dateValue;
        public cls_elementReference elementReference;
        public cls_numberValue numberValue;
        public cls_stringValue stringValue;
    }
    class cls_dynamicChoiceSets {
    }
    class cls_formulas {
        public String dataType;	//Boolean
        public cls_description description;
        public String expression;	//AND(
        public String name;	//formula_myRule_1
        public cls_processMetadataValues[] processMetadataValues;
        public cls_scale scale;
    }
    class cls_scale {
    }
    class cls_loops {
    }
    class cls_recordCreates {
    }
    class cls_recordDeletes {
    }
    class cls_recordLookups {
    }
    class cls_recordUpdates {
    }
    class cls_screens {
    }
    class cls_steps {
    }
    class cls_subflows {
    }
    class cls_textTemplates {
    }
    class cls_urls {
    }
    class cls_variables {
        public String dataType;	//SObject
        public cls_description description;
        public boolean isCollection;
        public boolean isInput;
        public boolean isOutput;
        public String name;	//myVariable_current
        public String objectType;	//Lead
        public cls_processMetadataValues[] processMetadataValues;
        public cls_scale scale;
        public cls_value value;
    }
    class cls_waits {
    }
    public static UpeoAnalyzerPBDetailWrapper parse(String json){
        return (UpeoAnalyzerPBDetailWrapper) System.JSON.deserialize(json, UpeoAnalyzerPBDetailWrapper.class);
    }
}