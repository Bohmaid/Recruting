@isTest
public class TestFactory {
    
    public static Profile getSimpleProfile(){
        Profile prof = [SELECT Id FROM Profile WHERE UserType='Standard' LIMIT 1]; 
        return prof;
    }
    public static User getStandardUser()
    {
        Profile profile = getSimpleProfile();
        
        User u = new User
            (
                alias = 'User1'
                , email='test'+System.now().getTime()+'@csc.com' 
                , emailencodingkey='ISO-8859-1'
                , lastname='Test' 
                , languagelocalekey='fr' 
                , localesidkey='fr_FR_EURO'
                , profileid = profile.Id
                , timezonesidkey='Europe/Paris'
                , username='test'+System.now().getTime()+'@csc.com'
                
                
            );
        return u;
    }
    
    public static Job_Application__c getSimplejob(){
        return new Job_Application__c
            
            (
                Status__c        = JobAppManager.STATUS_rejected                                      
            );    
    }
    public static review__c getSimplereview(Id jobid){
        return new review__c
            
            (
                Job_Application__c = jobid
                ,review_status__c        = reviewManager.STATUS_COMPLETED
            );    
    }
}