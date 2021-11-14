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
private class UpeoAnalyzerFlowMetricsControllerTest {


    @IsTest
    static void fetchDataTest() {
        List<SObject> objRecords = UpeoAnalyzerFlowMetricsController.fetchData();
    }

    @IsTest
    static void flowMetricsTest() {

        UpeoAnalyzerFlowMetricsController.flowMetrics();
    }
}