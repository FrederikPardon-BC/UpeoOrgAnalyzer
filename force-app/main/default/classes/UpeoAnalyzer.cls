public class UpeoAnalyzer {

    public static void getAllMetrics(){

        getSobjectRecordCount();
        getOldRecordDate();
        getActiveValidationRules();
        getFlowMetrics();
        getWorkflowRules();
        getAllObjectsFieldData();
        getProcessBuilders();


    }

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
                aom.Flow_Name__c = flowDef.get(flow.FlowDeveloperName).ApiName;
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

    @future(callout = true)
    public static void getLimits(){

        List<Additional_Org_Metrics__c> addMetrics = new List<Additional_Org_Metrics__c>();

        String reqUrl = 'callout:UpeoOptimizer/services/data/v52.0/limits';
        String responseBody = UpeoAnalyzerToolingRequest.request(reqUrl);

        Map<String, Object> payload = (Map<String, Object>)JSON.deserializeUntyped(responseBody);

        for(String lim : payload.keySet()) {
            Object data = payload.get(lim);
            Map<String, Object> record = (Map<String, Object>) data;
            system.debug(lim);
            system.debug(record.get('Max'));
            system.debug(record.get('Remaining'));

            Additional_Org_Metrics__c aom = new Additional_Org_Metrics__c();
            aom.Component_Name__c = lim;
            aom.Category__c = 'Org';
            aom.Feature_Type__c = 'Limits';
            aom.External_Id__c = lim+'Limits';
            aom.Limit_Max__c = (Integer)record.get('Max');
            aom.Limit_Remaining__c = (Integer)record.get('Remaining');
            addMetrics.add(aom);
        }

        upsert addMetrics External_Id__c;


    }

    @future(callout = true)
    public static void getSobjectRecordCount() {

        system.debug('getSobjectRecordCount method was called');
        system.debug(UserInfo.getName());

        List<Additional_Org_Metrics__c> addMetrics = new List<Additional_Org_Metrics__c>();
        List<Additional_Org_Metrics__c> aomList = new List <Additional_Org_Metrics__c>();

        String reqUrl = 'callout:UpeoOptimizer/services/data/v52.0/limits/recordCount';
        String responseBody = UpeoAnalyzerToolingRequest.request(reqUrl);

        system.debug(responseBody);

        UpeoAnalyzerRecordCount tResult = UpeoAnalyzerRecordCount.parse(responseBody);
        system.debug(tResult);

        Map<String, Object> payload = (Map<String, Object>)JSON.deserializeUntyped(responseBody);

        for(UpeoAnalyzerRecordCount.cls_sObjects res : tResult.sObjects){
            system.debug(res.count);
            Additional_Org_Metrics__c aom = new Additional_Org_Metrics__c();
            String objName = (String) res.name;
            Integer objCount = (Integer) res.count;

            SObjectType objType = Schema.getGlobalDescribe().get(objName);
            Boolean isUpdateable = objType.getDescribe().isUpdateable();
            Boolean isMruEnabled = objtype.getDescribe().isMruEnabled();
            Boolean isManaged = false;
            if (isUpdateable && isMruEnabled) {

                if(objName.countMatches('__') > 1){
                    isManaged = true;
                }

                Boolean custom = objType.getDescribe().isCustom();
                aom.Component_Name__c = objName + ' Size';
                aom.Category__c = 'Objects';
                aom.Feature_Type__c = 'Large Volumes';
                aom.Object__c = objName;
                aom.External_Id__c = objName + '-' + aom.Feature_Type__c;
                aom.Total_Records__c = objCount;
                aom.Custom__c = custom;
                aom.Part_of_Managed_Package__c = isManaged;
                aomList.add(aom);
            }
        }

        upsert aomList External_Id__c;

    }

    public static void getOldRecordDate(){

        List<Additional_Org_Metrics__c> aomList = new List<Additional_Org_Metrics__c>();

        for(Additional_Org_Metrics__c aom : [SELECT Id, Object__c, External_Id__c FROM Additional_Org_Metrics__c
        WHERE Feature_Type__c = 'Large Volumes'
        Order By Total_Records__c DESC
        Limit 10
        ]){

            String query = 'SELECT Count() From ' +aom.Object__c + ' where LastModifiedDate < LAST_N_YEARS:1';
            system.debug(query);
            Integer count = Database.countQuery(query);
            aom.Number_of_Old_Records__c = count;
            aomList.add(aom);
        }

        upsert aomList External_Id__c;


    }
    public static void getWorkflowRules() {

        Id batchId = Database.executeBatch(new UpeoAnalyzerWorflowMetricsBatch(), 45);

    }

    public static void getProcessBuilders(){

        String baseUrl = 'callout:UpeoOptimizer';
        String query = '/services/data/v51.0/tooling/query?q=SELECT+Id,Definition.DeveloperName,count(Status)+FROM+Flow+WHERE+ProcessType=\'Workflow\'+Group+by+Definition.DeveloperName,Id';

        string responseBody = UpeoAnalyzerToolingRequest.request(baseUrl+query);
        UpeoAnalyzerFlowWrapper qResult = UpeoAnalyzerFlowWrapper.parse(responseBody);

        List<Additional_Org_Metrics__c> aomList = new List<Additional_Org_Metrics__c>();

        for(UpeoAnalyzerFlowWrapper.cls_records flow :qResult.records ){

            Additional_Org_Metrics__c aom = new Additional_Org_Metrics__c();
            aom.Category__c = 'Process Builder';
            aom.Feature_Type__c = 'Process Builder';
            aom.Component_Name__c =  flow.DeveloperName;
            aom.External_Id__c = 'ProcessBuilder-' + flow.DeveloperName;
            aom.Process_Builder_Versions__c = (Integer) flow.expr0;
            aom.Component_Id__c = flow.Id;
            aomList.add(aom);
        }

        upsert aomList External_Id__c;

    }

    @future(callout = true)
    public static void getActiveValidationRules() {

        system.debug('getActiveValidationRules method was called');
        system.debug(UserInfo.getName());

        List<Additional_Org_Metrics__c> addMetrics = new List<Additional_Org_Metrics__c>();
        string reqUrl = 'callout:UpeoOptimizer/services/data/v47.0/tooling/query/?q=SELECT+Id,ValidationName,Active,EntityDefinition.DeveloperName,ErrorMessage+FROM+ValidationRule';

        string responseBody = UpeoAnalyzerToolingRequest.request(reqUrl);

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

            Id batchId = Database.executeBatch(new UpeoAnalyzerBatchFieldUsage(qry, fieldMap, objString));
        }
    }

    public static void getRecordCounts(List<String> objList){

        List<Additional_Org_Metrics__c> aomList = new List<Additional_Org_Metrics__c>();

        for (String obj : objList ){

            SObjectType type = Schema.getGlobalDescribe().get(obj);
            String objName = type.getDescribe().getName();

            //I know this is bad, but I'm still looking for a better way to do this.
            //For now it will have to do.
            String q = 'SELECT Count() FROM ' + objName;
            Integer count = Database.countQuery(q);

            Additional_Org_Metrics__c aom = new Additional_Org_Metrics__c();

            aom.Category__c = 'Objects';
            aom.Feature_Type__c = 'Large Volumes';
            aom.Object__c = obj;
            aom.External_Id__c = obj + '-' + aom.Feature_Type__c;
            aom.Total_Records__c = count;
            aomList.add(aom);
        }

        upsert aomList External_Id__c;
    }

    public static void geSelectedFieldUsage(List<String> fieldList, String objType){

        system.debug('getFieldUsage was called');

        String qry = 'SELECT ' + String.join(fieldList, ',') + ' FROM ' + objType;
        system.debug(qry);
        Id batchId = Database.executeBatch(new UpeoAnalyzerBatchSelectedFieldUsage(qry, fieldList, objType));
    }

    public static void getAllObjectsFieldData(){


        List<Additional_Org_Metrics__c> aomList = new List<Additional_Org_Metrics__c>();

        for(Schema.SObjectType objType : Schema.getGlobalDescribe().Values()){
            String name = objType.getDescribe().getName();
            Schema.DescribeSObjectResult objResult = objType.getDescribe();
            // Exclude all the unwanted Sobjects e.g. History, Share etc..
            Boolean isQueryable = objType.getDescribe().isQueryable();
            Boolean isUpdateable = objType.getDescribe().isUpdateable();
            Boolean isMruEnabled = objType.getDescribe().isMruEnabled();
            Boolean isCustom = objType.getDescribe().isCustom();
            Boolean isManaged;
            Map<String, Schema.SObjectField> fieldMap = objResult.fields.getMap();
            Integer nbrOfFields = fieldMap.size();
            Additional_Org_Metrics__c aom = new Additional_Org_Metrics__c();


            if(name.countMatches('__') > 1){
                isManaged = true;
            } else {
                isManaged = false;
            }

            if(isQueryable && isUpdateable && isMruEnabled && !isManaged) {

                if (!name.containsignorecase('history') && !name.containsignorecase('tag') &&
                        !name.containsignorecase('share') && !name.containsignorecase('feed')) {
                    aom.Component_Name__c = name + ' Fields';
                    aom.Object__c = name;
                    aom.Category__c = 'Objects';
                    aom.Feature_Type__c = 'Number of Fields';
                    aom.Number_of_Fields__c = nbrOfFields;
                    aom.External_Id__c = name + '-' + aom.Feature_Type__c;
                    aom.Custom__c = isCustom;
                    aomList.add(aom);

                }
            }
        }

        upsert aomList External_Id__c;


    }
}