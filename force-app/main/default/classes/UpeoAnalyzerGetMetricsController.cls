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
 * Created: 13/11/2021
 * Last Updated: 13/11/2021
 *
 * Unit tests:
 *
 * Change log:
 * -----------------------------------------------------------------------------------------------
*/
public class UpeoAnalyzerGetMetricsController {

    @AuraEnabled
    public static void getOrgMetrics(){
        UpeoAnalyzer.getAllMetrics();
    }

}