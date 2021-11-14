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

public class UpeoAnalyzerRecordCount {
    public cls_sObjects[] sObjects;
    public class cls_sObjects {
        public Integer count;    //0
        public String name;    //Contract
    }
    public static UpeoAnalyzerRecordCount parse(String json) {
        return (UpeoAnalyzerRecordCount) System.JSON.deserialize(json, UpeoAnalyzerRecordCount.class);
    }
}


