({
    init: function (cmp, event, helper) {
        cmp.set('v.columns', [
            { label: 'Details', fieldName: 'linkName', type: 'url', typeAttributes:{label: { fieldName: 'Name' }, target: '_blank'}},
            { label: 'Flow Name', fieldName: 'Component_Name__c', type: 'text' },
            { label: 'Execution Times', fieldName: 'Flow_Execution_Times__c', type: 'number' },
            { label: 'Execution Duration', fieldName: 'Flow_Runtime_Duration__c', type: 'decimal' },
            { label: 'Last Execution Time', fieldName: 'Flow_Last_Run__c', type: 'date', typeAttributes:{
                                                                                                            year: "numeric",
                                                                                                            month: "long",
                                                                                                            day: "2-digit",
                                                                                                            hour: "2-digit",
                                                                                                            minute: "2-digit"
        																								}
            }
        ]);
        var action = cmp.get("c.fetchData");
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var records =response.getReturnValue();
                 records.forEach(function(record){
                    record.linkName = '/'+record.Id;
                });
                cmp.set("v.data", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    
    getFlowMetrics: function(component, event, helper){
        console.log('ran getFlowMetrics');
        var action = component.get("c.flowMetrics");
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