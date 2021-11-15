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
public class UpeoAnalyzerWorflowMetricsBatch implements Database.Batchable<Object>, Database.AllowsCallouts  {

    public list<Object> stringList = new List<Object>{'abc', 'def'};


    public Iterable <object> start(Database.BatchableContext BC) {

        String reqUrl = 'callout:UpeoOptimizer/services/data/v47.0/tooling/query/?q=' +
                'Select+Id,Name,TableEnumOrId+From+WorkflowRule';

        String responseBody = UpeoAnalyzerToolingRequest.request(reqUrl);

        UpeoAnalyzerWfrBasic wfrBasic = UpeoAnalyzerWfrBasic.parse(responseBody);

        List<Object> objList = wfrBasic.records;

        return objList;

    }

    public void execute(Database.BatchableContext BC, List<Object> scope) {

        List<Additional_Org_Metrics__c> addMetrics = new List<Additional_Org_Metrics__c>();

        for(Object o : scope){

            UpeoAnalyzerWfrBasic.cls_records detail = (UpeoAnalyzerWfrBasic.cls_records)o;
            Additional_Org_Metrics__c aom = new Additional_Org_Metrics__c();

            System.debug(detail.attributes.url);
            String detailUrl = (String) detail.attributes.url;
            String baseUrl = 'callout:UpeoOptimizer/';
            String wfrDetails = UpeoAnalyzerToolingRequest.request(baseUrl+detailUrl);
            WFRToolingResult wfrDetailResult = WFRToolingResult.parse(wfrDetails);

            aom.Component_Name__c = wfrDetailResult.Name;
            aom.Category__c = 'Workflow';
            if(wfrDetailResult.Metadata.active) {
                aom.Feature_Type__c = 'Active Workflow Rules';
            } else {
                aom.Feature_Type__c = 'Inactive Workflow Rules';
            }
            aom.Active__c = wfrDetailResult.Metadata.active;
            aom.Object__c = wfrDetailResult.TableEnumOrId;
            aom.External_Id__c = 'WFR' +wfrDetailResult.Id;
            aom.Flow_Trigger_Type__c = wfrDetailResult.Metadata.triggerType;
            if(wfrDetailResult.ManageableState.contains('installed')){
                aom.Part_of_Managed_Package__c = true;
            } else {aom.Part_of_Managed_Package__c = false;}

            addMetrics.add(aom);

        }

        upsert addMetrics External_Id__c;

    }




    public void finish(Database.BatchableContext BC){

    }

}