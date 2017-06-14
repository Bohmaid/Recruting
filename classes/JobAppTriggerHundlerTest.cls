@isTest
public class JobAppTriggerHundlerTest {
    static void onBeforeUpdateTest(){
        user u = TestFactory.getStandardUser();
        insert u;
        
        List<Job_Application__c> listeJobtoInsert = new List <Job_Application__c>();
        Job_Application__c jobtoinsert = TestFactory.getSimplejob();
        jobtoinsert.Status__c=JobAppManager.STATUS_rejected;
        listeJobtoInsert.add(jobtoinsert);
        List<Job_Application__c> ListJobApp = JobAppManager.insertJobApps(listeJobtoInsert);
        Job_Application__c jobDataBase = ListJobApp[0];
        List<Review__c> listreviewtoinsert = new List <Review__c>();
        Review__c reviewComp = TestFactory.getSimplereview(jobDataBase.Id);
        
        reviewcomp.review_status__c = reviewManager.STATUS_COMPLETED;
        Review__c reviewIn = TestFactory.getSimplereview(jobDataBase.Id);
        
        reviewIn.review_status__c = reviewManager.STATUS_IN_PROGRESS;
        listreviewtoinsert.add(reviewcomp);
        listreviewtoinsert.add(reviewIn);
        List<Review__c> ListRev = reviewManager.insertReview(listreviewtoinsert);
        
        System.Test.startTest();
        System.runAs(u){
            
           
            List<Job_Application__c> ListeJobtoUpdate = new List<Job_Application__c>();
            jobtoinsert.Status__c = JobAppManager.STATUS_COMPLETED;
            ListeJobtoUpdate.add(jobtoinsert);
            
            try{
                ListJobApp=JobAppManager.updateJobApps(ListJobApp);
            }catch(Exception e){
                System.assertNotEquals(ListJobApp.size(), null);
            }
            System.assertEquals(ListJobApp.size(), 1);
            System.assert(Limits.getQueries() < 0.9 * Limits.getLimitQueries()); 
        }
        System.Test.stopTest();
    }
    
}