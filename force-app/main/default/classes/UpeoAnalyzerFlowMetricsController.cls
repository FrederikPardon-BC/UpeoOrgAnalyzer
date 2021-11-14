public class UpeoAnalyzerFlowMetricsController {
    
	@AuraEnabled
    public static List<sObject> fetchData() {
        //Query and return list of Contacts
        List<SObject> objRecords = [Select Name, Component_Name__c, Flow_Execution_Times__c, Flow_Last_Run__c, Flow_Process_Type__c, Flow_Runtime_Duration__c, Flow_Trigger_Type__c  from Additional_Org_Metrics__c where Category__c = 'Flow' and Feature_Type__c = 'Flow Runtimes'];
        return objRecords;
    }

	@AuraEnabled
    public static void flowMetrics(){
        system.debug('ran flowMetrics');
        UpeoAnalyzer.getFlowMetrics();
    }    

}