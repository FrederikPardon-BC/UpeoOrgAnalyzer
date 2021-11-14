/**
 * Created by Frederik on 13/11/2021.
 */

({

        getOrgMetrics : function(component) {
            console.log('orgMetrics executed');
            var action = component.get("c.getOrgMetrics");
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    console.log("Success with state: " + state);
                }
                else {
                    console.log("Failed with state: " + state);
                }
            });
            $A.enqueueAction(action);
        },

       showToast : function(component, event, helper) {
           var toastEvent = $A.get("e.force:showToast");
           toastEvent.setParams({
               "title": "Success!",
               "message": "Your Org is being analyzed, give us a minute before refreshing the page"
           });
           toastEvent.fire();
       }


});