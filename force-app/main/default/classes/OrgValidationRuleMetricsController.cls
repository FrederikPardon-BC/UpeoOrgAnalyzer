public class OrgValidationRuleMetricsController {
    
    @AuraEnabled
    public static List<sObject> fetchActiveValidationData() {
        //Query and return list of Contacts
        List<SObject> objRecords = [Select Name, Component_Name__c, Object__c, Active__c  from Additional_Org_Metrics__c where Category__c = 'Validation Rules' and Active__c = true];
        return objRecords;
    }
    
    @AuraEnabled
    public static List<sObject> fetchInactiveValidationData() {
        //Query and return list of Contacts
        List<SObject> objRecords = [Select Name, Component_Name__c, Object__c, Active__c  from Additional_Org_Metrics__c where Category__c = 'Validation Rules' and Active__c = false];
        return objRecords;
    }

	@AuraEnabled
    public static void validationMetrics(){
        system.debug('ran validationMetrics');
        OptimizerAdditional.getActiveValidationRules();
    }   

}