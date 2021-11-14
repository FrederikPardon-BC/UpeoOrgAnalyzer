({
    init: function (cmp, event, helper) {
        cmp.set('v.columns', [
            { label: 'Details', fieldName: 'linkName', type: 'url', typeAttributes:{label: { fieldName: 'Name' }, target: '_blank'}},
            { label: 'Rule Name', fieldName: 'Component_Name__c', type: 'text' },
            { label: 'Object', fieldName: 'Object__c', type: 'text' },
            { label: 'Active', fieldName: 'Active__c', type: 'boolean', sortable: true },
        ]);
        var action = cmp.get("c.fetchActiveValidationData");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var records =response.getReturnValue();
                 records.forEach(function(record){
                    record.linkName = '/'+record.Id;
                });
                cmp.set("v.activedata", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
            
        var actionInactive = cmp.get("c.fetchInactiveValidationData");
        actionInactive.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var records =response.getReturnValue();
                 records.forEach(function(record){
                    record.linkName = '/'+record.Id;
                });
                cmp.set("v.inactivedata", response.getReturnValue());
            }
        });
        $A.enqueueAction(actionInactive);
    },
    
    getValidationMetrics: function(component, event, helper){
        console.log('ran validationMetrics');
        var action = component.get("c.validationMetrics");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log("Success with state: " + state);
                 $A.get('e.force:refreshView').fire();
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);       
    }
            
})