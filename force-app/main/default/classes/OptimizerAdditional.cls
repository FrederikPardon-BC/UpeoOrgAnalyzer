public class OptimizerAdditional {

    public static void getFlowMetrics(){

        List<FlowInterviewLog> flowLogs = [select Name, CreatedDate, CreatedBy.Name, FlowDeveloperName, InterviewStartTimestamp, InterviewEndTimestamp, InterviewDurationInMinutes, InterviewStatus, FlowLabel from FlowInterviewLog];
        List<String> flows = new List<String>();

        for(FlowInterViewLog fLog :flowLogs){
            flows.add(fLog.FlowDeveloperName);
        }

        Set<String> distinctFlows = new Set<String>(flows);

        List<FlowDefinitionView> flowData = [select Id, ApiName, Description, ProcessType, TriggerType from FlowDefinitionView];

        Map<String, FlowDefinitionView> flowDef = new Map<String, FlowDefinitionView>();
        for(FlowDefinitionView fDefinition : flowData){
            flowDef.put(fDefinition.ApiName, fDefinition);
        }

        Map<String, Additional_Org_Metrics__c> orgMetrics = new Map<String, Additional_Org_Metrics__c>();

        for(FlowInterViewLog flow : flowLogs){
            Additional_Org_Metrics__c aom = new Additional_Org_Metrics__c();

            if(orgMetrics.containsKey(flow.FlowDeveloperName)) {
                aom = orgMetrics.get(flow.FlowDeveloperName);
                aom.Flow_Execution_Times__c++;
                if(aom.Flow_Last_Run__c < flow.CreatedDate){
                    aom.Flow_Last_Run__c = flow.CreatedDate;
                }
                aom.Flow_Runtime_Duration__c = flow.InterviewDurationInMinutes;
            } else {
                aom.Category__c = 'Flow';
                aom.Feature_Type__c = 'Flow Runtimes';
                aom.Component_Name__c = flow.FlowDeveloperName;
                aom.Flow_Execution_Times__c=1;
                aom.Flow_Last_Run__c = flow.CreatedDate;
                aom.Flow_Process_Type__c = flowDef.get(flow.FlowDeveloperName).ProcessType;
                aom.Flow_Trigger_Type__c = flowDef.get(flow.FlowDeveloperName).TriggerType;
                aom.External_Id__c = 'Flow-'+flow.FlowDeveloperName;
                aom.Flow_Runtime_Duration__c = flow.InterviewDurationInMinutes;
            }

            orgMetrics.put(flow.FlowDeveloperName, aom);

        }

        upsert(orgMetrics.values()) External_Id__c;

    }
    
    public static void getActiveValidationRules() {

        system.debug('getActiveValidationRules method was called');
        system.debug(UserInfo.getName());

        List<Additional_Org_Metrics__c> addMetrics = new List<Additional_Org_Metrics__c>();

        Http httpProtocol = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(
                'callout:UpeoOptimizer/services/data/v47.0/tooling/query/?q='+
                'SELECT+Id,ValidationName,Active,EntityDefinition.DeveloperName,ErrorMessage+'+
                'FROM+ValidationRule');
        //setting method and header
        req.setMethod('GET');
        req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());
        system.debug(UserInfo.getSessionId());
        HttpResponse resp = httpProtocol.send(req);
        String responseBody = resp.getBody();
        system.debug(responseBody);
        Map<String, Object> payload = (Map<String, Object>)JSON.deserializeUntyped(responseBody);

        for(Object data : (List<Object>)payload.get('records')){
            Map<String, Object> record = (Map<String, Object>)data;
            Boolean active = (Boolean)record.get('Active');
            if (active == TRUE) {
                Additional_Org_Metrics__c aom = new Additional_Org_Metrics__c();
                Map<String, Object> entityDefinition = (Map<String, Object>)record.get('EntityDefinition');
                aom.Component_Name__c = (String)record.get('ValidationName');
                aom.Feature_Type__c = 'Active Validation Rules';
                aom.Category__c = 'Validation Rules';
                aom.Object__c = (String)entityDefinition.get('DeveloperName');
                aom.Active__c = (Boolean)record.get('Active');
                aom.Description__c = (String)record.get('ErrorMessage');
                aom.External_Id__c = 'ValidationRule-' +(String)record.get('Id');
                addMetrics.add(aom);
            }
            else {
                Additional_Org_Metrics__c aom = new Additional_Org_Metrics__c();
                Map<String, Object> entityDefinition = (Map<String, Object>)record.get('EntityDefinition');
                aom.Component_Name__c = (String)record.get('ValidationName');
                aom.Feature_Type__c = 'Inactive Validation Rules';
                aom.Category__c = 'Validation Rules';
                aom.Object__c = (String)entityDefinition.get('DeveloperName');
                aom.Active__c = (Boolean)record.get('Active');
                aom.Description__c = (String)record.get('ErrorMessage');
                aom.External_Id__c = 'ValidationRule-' +(String)record.get('Id');
                addMetrics.add(aom);
            }

        }

        upsert addMetrics External_Id__c;
        
    }

    public static void getFieldUsage(List<String> objectTypes){

        system.debug('getFieldUsage was called');

        for(String objString :objectTypes) {

            system.debug('Current object = ' +objString);

            SObjectType type = Schema.getGlobalDescribe().get(objString);

            Map<String, Schema.SObjectField> fieldMap = type.getDescribe().fields.getMap();
            Set<String> setFieldName = fieldMap.keySet();
            List<String> lstFieldNames = new List<String>(setFieldName);

            String qry = 'SELECT ' + String.join(lstFieldNames, ',') + ' FROM ' + objString;
            system.debug(qry);

            Id batchId = Database.executeBatch(new BatchFieldUsage(qry, fieldMap, objString));
        }
    }

    public static void geSelectedFieldUsage(List<String> fieldList, String objType){

        system.debug('getFieldUsage was called');

        String qry = 'SELECT ' + String.join(fieldList, ',') + ' FROM ' + objType;
        system.debug(qry);
        Id batchId = Database.executeBatch(new BatchSelectedFieldUsage(qry, fieldList, objType));
    }
}