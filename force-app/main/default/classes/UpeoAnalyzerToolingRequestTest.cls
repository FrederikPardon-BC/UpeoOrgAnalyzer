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
private class UpeoAnalyzerToolingRequestTest {

    @isTest static void testCallout() {
        // Set mock callout class
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        String reqUrl = '';

        // Call method to test.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock.
        String res = UpeoAnalyzerToolingRequest.request('http://example.com/example/test');
        system.debug(res);
        string actualValue = res;
        string expectedValue = '{"example":"test"}';

        // Verify response received contains fake values
        System.assertEquals(actualValue, expectedValue);

    }
}