({
    // Load expenses from Salesforce
    doInit: function(component, event, helper) {
        console.log('running doInit');
        // Create the action
        var action = component.get("c.getAllObjects");
        // Add callback behavior for when response is received
        var opts=[];
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log(response.getReturnValue());
            if (state == "SUCCESS") {
                console.log(state);
               component.set("v.data", response.getReturnValue());
               var allValues = response.getReturnValue();
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        class: "optionClass",
                        label: allValues[i],
                        value: allValues[i]
                    });
            }
                 try{
                    component.find("SobjectList").set("v.options", opts);
                 } catch (error) {
                    component.find("SobjectSingle").set("v.options", opts);
                 }
                 component.set("v.UnfilteredData", opts);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    
    handleChange: function (component, event) {
        // This will contain an array of the "value" attribute of the selected options
            var selectedValues = event.getParam("value");
        	if(selectedValues != null){
            component.set("v.values", selectedValues);
        	console.log(selectedValues);
            }
    },

    getFieldUsage: function(component, event, helper){
        var selectedValues = component.get("v.selectedObjectList");
        helper.getFieldUsage(component);
        helper.showToast(component);
    },
    
    getObjectSize: function(component, event, helper){
        console.log('executing getObjectSize');
        var selectedValues = component.get("v.selectedObjectList");
        helper.getObjectSize(component);
        helper.showToast(component);
    },

    getFieldUsageSingle: function(component, event, helper){
        var selectedValues = component.find("SobjectSingle").get("v.value");
        helper.getSelectedFieldUsage(component);
        helper.showToast(component);
    },

    doFilter: function(component, event, helper) {
         //calling helper
         helper.FilterRecords(component);
    },

    getFields: function(component, event, helper) {
        var action = component.get("c.getAllFields");
        var userObj= component.find("SobjectSingle").get("v.value");
        console.log(userObj);

        if(userObj != null){
            action.setParams({
                    "fld": userObj
            });
                  // Add callback behavior for when response is received
            var opts=[];
            action.setCallback(this, function(response) {
                var state = response.getState();
                console.log(response.getReturnValue());
                if (state == "SUCCESS") {
                   var allValues = response.getReturnValue();
                    for (var i = 0; i < allValues.length; i++) {
                        opts.push({
                            class: "optionClass",
                            label: allValues[i],
                            value: allValues[i]
                        });
                }
                    component.find("FieldsList").set("v.options", opts);
                }
                else {
                    console.log("Failed with state: " + state);
                }
            });
            // Send action off to be executed
            $A.enqueueAction(action);
        }
    }


})