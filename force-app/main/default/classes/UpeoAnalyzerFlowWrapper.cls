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
public class UpeoAnalyzerFlowWrapper {
    public Integer size;    //340
    public Integer totalSize;    //340
    public boolean done;
    public cls_queryLocator queryLocator;
    public String entityTypeName;    //AggregateResult
    public cls_records[] records;
    class cls_queryLocator {
    }
    public class cls_records {
        public cls_attributes attributes;
        public String DeveloperName;    //CartOrderItemUnitOfMeasureFillIn
        Public String Id;
        public Integer expr0;    //2
    }
    class cls_attributes {
        public String type;    //AggregateResult
    }
    public static UpeoAnalyzerFlowWrapper parse(String json) {
        return (UpeoAnalyzerFlowWrapper) System.JSON.deserialize(json, UpeoAnalyzerFlowWrapper.class);
    }
}