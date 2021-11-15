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
    public Integer size;
    public Integer totalSize;
    public Boolean done;
    public Object queryLocator;
    public String entityTypeName;
    public List<Records> records;

    public class Attributes {
        public String type;
        public String url;
    }

    public class Definition {
        public Attributes attributes;
        public String DeveloperName;
    }

    public class Records {
        public Attributes attributes;
        public String Id;
        public Definition Definition;
        public String Status;
    }
    public static UpeoAnalyzerFlowWrapper parse(String json) {
        return (UpeoAnalyzerFlowWrapper) System.JSON.deserialize(json, UpeoAnalyzerFlowWrapper.class);
    }
}