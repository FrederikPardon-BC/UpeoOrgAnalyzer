/**
 * Created by Frederik on 13/11/2021.
 */

({

        handleClick: function(component, event, helper){
            console.log('handleClick executed');
            helper.getOrgMetrics(component);
            helper.showToast(component);
        }


});