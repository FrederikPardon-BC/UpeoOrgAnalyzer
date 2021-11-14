/**
 * @Version: 1.0
 * @Author: Frederik
 * @Copyright: 2021 Upeo Consulting
 * @Uses:
 *
 * -----------------------------------------------------------------------------------------------
 * Description: 
 *
 *
 * Created: 14/11/2021
 * Last Updated: 14/11/2021
 *
 * Unit tests:
 *
 * Change log:
 * -----------------------------------------------------------------------------------------------
*/
@IsTest
private class UpeoAnalyzerObjectSelectorControllerTest {
    @IsTest
    static void getAllObjectsTest() {
        UpeoAnalyzerObjectSelectorController.getAllObjects();
    }

    @IsTest
    static void getAllFieldsTest() {

        String str = 'Account';
        UpeoAnalyzerObjectSelectorController.getAllFields(str);
    }

    @IsTest
    static void apexGetFieldUsageTest() {

        List<String> objectTypes = new list<string>{'Account','Contact'};
        UpeoAnalyzerObjectSelectorController.apexGetFieldUsage(objectTypes);

    }

    @IsTest
    static void apexGetObjectSizeTest() {

        List<String> objectTypes = new list<string>{'Account','Contact'};
        UpeoAnalyzerObjectSelectorController.apexGetObjectSize(objectTypes);
    }

    @IsTest
    static void apexSelectedFieldUsage() {

        List<String> fieldList = new list<string>{'Name'};
        String objType = 'Account';

        UpeoAnalyzerObjectSelectorController.apexSelectedFieldUsage(fieldList, objType);

    }


}