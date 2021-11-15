/**
 * Created by fpardon on 15/11/2021.
 */

public class UpeoAnalyzerFlowAggregate {

    public Integer size;
    public Integer totalSize;
    public Boolean done;
    public Object queryLocator;
    public String entityTypeName;
    public List<Records> records;

    public class Attributes {
        public String type;
    }

    public class Records {
        public Attributes attributes;
        public String DeveloperName;
        public Integer expr0;
    }


    public static UpeoAnalyzerFlowAggregate parse(String json) {
        return (UpeoAnalyzerFlowAggregate) System.JSON.deserialize(json, UpeoAnalyzerFlowAggregate.class);
    }
}