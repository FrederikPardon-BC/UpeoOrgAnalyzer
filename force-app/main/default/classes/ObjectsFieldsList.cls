public class ObjectsFieldsList{
    @AuraEnabled
    public static List<string> getAllObjects(){
	List<string> SObjectList = new List<string>();

    for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
       String name = objTyp.getDescribe().getName();
       // Exclude all the unwanted Sobjects e.g. History, Share etc..

        if(objTyp.getDescribe().isQueryable()) {

            if (!name.containsignorecase('history') && !name.containsignorecase('tag') &&
                    !name.containsignorecase('share') && !name.containsignorecase('feed')) {
                SobjectList.add(name);
                System.debug('Name : ' + name);
            }
        }

	}
    sObjectList.sort();    
    return SObjectList;
	}

    
    @AuraEnabled
    public static List<String> getAllFields(String fld){
        List<String> fieldList = new List<String>();
        Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        Schema.SObjectType sobjType = gd.get(fld); 
        Schema.DescribeSObjectResult describeResult = sobjType.getDescribe(); 
        Map<String,Schema.SObjectField> fieldsMap = describeResult.fields.getMap(); 
            for(string str: fieldsMap.keySet()) {
                if (fieldsMap.get(str).getDescribe().isPermissionable()) {
                    fieldList.add(fieldsMap.get(str).getDescribe().getName());
                }
            }
            return fieldList;      
        }

    @AuraEnabled
    public static void apexGetFieldUsage(List<String> objectList){
        OptimizerAdditional.getFieldUsage(objectList);
        system.debug('called getFieldUsage');
    }

    @AuraEnabled
    public static void apexSelectedFieldUsage(List<String> fieldList, String objType){
        OptimizerAdditional.geSelectedFieldUsage(fieldList, objType);
        system.debug('called getFieldUsage');
    }

    }