({
    getFieldUsage : function(component) {
        var action = component.get("c.apexGetFieldUsage");
        action.setParams({
            "objectList": component.get("v.values")
        });
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
    
    getObjectSize : function(component) {
        var action = component.get("c.apexGetObjectSize");
        action.setParams({
            "objectList": component.get("v.values")
        });
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

    getSelectedFieldUsage : function(component) {
        var action = component.get("c.apexSelectedFieldUsage");
        action.setParams({
            "fieldList": component.find("FieldsList").get("v.value"),
            "objType": component.find("SobjectSingle").get("v.value")
        });
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

   FilterRecords: function(component) {
     //data showing in table
     var selectedValues = component.get("v.values");
     console.log('during Filter Records the Selected Values are'  +selectedValues);
     var data = component.find("SobjectList").get("v.options");
     // all data fetched from apex when component loaded
     var allData = component.get("v.data");
     //Search tems
     var searchKey = component.get("v.filter");

     var opts=[];
     console.log('filter was loaded ' +searchKey);
     // check is data is not undefined and its lenght is greater than 0
     if(data!=undefined || data.length>0){
       // filter method create a new array tha pass the test (provided as function)

       var filtereddata = allData.filter(word => (!searchKey) || word.toLowerCase().indexOf(searchKey.toLowerCase()) > -1);

         for (var i = 0; i < selectedValues.length; i++) {
                    console.log('the current selected Value = ' +selectedValues[i]);
                    opts.push({
                        class: "optionClass",
                        label: selectedValues[i],
                        value: selectedValues[i]
                    })
        }

         for (var i = 0; i < allData.length; i++) {
                    opts.push({
                        class: "optionClass",
                        label: filtereddata[i],
                        value: filtereddata[i]
                    })
        }
     }


     // set new filtered array value to data showing in the table.
     component.find("SobjectList").set("v.options", opts);

     // check if searchKey is blank
     if(searchKey==''){
       // set unfiltered data to data in the table.
       component.find("SobjectList").set("v.options", component.get("v.UnfilteredData"));
     }
   },

   showToast : function(component, event, helper) {
       var toastEvent = $A.get("e.force:showToast");
       toastEvent.setParams({
           "title": "Success!",
           "message": "A background job has been scheduled to analyze the selected data"
       });
       toastEvent.fire();
   }
})