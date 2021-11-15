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
    //public cls_Description Description;
    public String ProcessType;	//Workflow
    public String CreatedDate;	//2021-08-27T13:31:48.000+0000
    public String CreatedById;	//00509000007iKmCAAU
    public String LastModifiedDate;	//2021-08-27T13:31:52.000+0000
    public String LastModifiedById;	//00509000007iKmCAAU
    public cls_Metadata Metadata;
    class cls_attributes {
        public String type;	//Flow
        public String url;	///services/data/v43.0/tooling/sobjects/Flow/301090000005whQAAQ
    }
    class cls_Description {
    }
    public class cls_Metadata {
        public cls_processMetadataValues[] processMetadataValues;
    }
    public class cls_processMetadataValues {
        public String name;	//ObjectType
        public cls_value value;
    }
    public class cls_value {
        public cls_booleanValue booleanValue;
        public cls_dateTimeValue dateTimeValue;
        public cls_dateValue dateValue;
        //public cls_elementReference elementReference;
        public cls_numberValue numberValue;
        public String stringValue;	//Lead
    }
    class cls_booleanValue {
    }
    class cls_dateTimeValue {
    }
    class cls_dateValue {
    }
    class cls_elementReference {
    }
    class cls_numberValue {
    }
    class cls_stringValue {
    }


    public static UpeoAnalyzerPBDetailWrapper parse(String json){
        return (UpeoAnalyzerPBDetailWrapper) System.JSON.deserialize(json, UpeoAnalyzerPBDetailWrapper.class);
    }
}