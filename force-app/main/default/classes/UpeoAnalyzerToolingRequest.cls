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
public Class UpeoAnalyzerToolingRequest {

    public static string request(string reqUrl) {

        Http httpProtocol = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(reqUrl);
        //setting method and header
        req.setMethod('GET');
        req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());
        HttpResponse resp = httpProtocol.send(req);
        String responseBody = resp.getBody();
        system.debug(responseBody);
        return(responseBody);
    }
}