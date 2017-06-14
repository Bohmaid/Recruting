@isTest
public class JobAppManagerTest {
    static void getListByreviewIdTest (){
        user u = TestFactory.getStandardUser();
        insert u;
        System.Test.startTest();
        System.runAs(u){
            List <Job_Application__c> ListjobApp = JobAppManager.insertJobApps(new List <Job_Application__c>{TestFactory.getSimplejob()});
            
            Set <Id> reviewsIds = new set <Id>();
            
           
        }
    }
    
}