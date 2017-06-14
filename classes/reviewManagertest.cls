@isTest
public class reviewManagertest {
    
    static void getListByJobIdTest(){
        user u = TestFactory.getStandardUser();
        insert u;
        
        System.Test.startTest();
        System.runAs(u){
            List<Job_Application__c> ListJobToInsert = new List<Job_Application__c>();
            Job_Application__c jobToInsert = TestFactory.getSimplejob();
            ListJobToInsert.add(jobToInsert);
            
            List<Job_Application__c> ListJob = JobAppManager.insertJobApps(new List<Job_Application__C>{TestFactory.getSimplejob()});
            Job_Application__c ja = ListJob[0];
            List<Review__c> ListRev = reviewManager.insertReview(new List<Review__c>{TestFactory.getSimplereview(ja.Id)});
            Set <Id> JobApplicationsIds = new set <Id>();
            JobApplicationsIds.add(ja.Id);
            List<review__c> Listresult = reviewManager.getListByJobId(JobApplicationsIds);
            System.assertEquals(Listresult.size(),1);
            
        }
    }
    
    
}