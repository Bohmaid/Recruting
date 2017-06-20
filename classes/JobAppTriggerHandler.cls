public class JobAppTriggerHandler {
    /***********************************/
    /*************AHMED ZRAIGA**********/
    /*************AHMED ZRAIGA**********/
    /*whjvhgvfhjsdf***/
    /*whjvhgvfhjsdf***/
    private static String CLASS_NAME = JobAppTriggerHandler.class.getName();
    
    public void onBeforeUpdate(List<Job_Application__c> JobAppsList, Map<id, Job_Application__c> oldMapJobApps){
        
        
        
        String currentUserId = UserInfo.getUserId();
        Set <Id> setIdJobAppToTrait = new set <Id>();
        for(Job_Application__c job : JobAppsList) {
            
            if(oldMapJobApps.get(job.Id).Status__c != job.Status__c && job.Status__c==JobAppManager.STATUS_COMPLETED){
                setIdJobAppToTrait.add(job.Id);
            }
        }
        
        List<review__c> listReview =  reviewManager.getListByJobId(setIdJobAppToTrait);
        
        Map<Id, List<review__c>> mapReviewByJobId = initMapReviewByJobId(listReview);
        
        System.debug('this is a test [listReview]' +listReview);
        
        for(Job_Application__c job: JobAppsList){
            
            if(mapReviewByJobId.containsKey(Job.Id)){
                boolean JobIsNotCompleted=false;
                for(Review__c R : mapReviewByJobId.get(Job.Id)){
                    if(R.review_Status__c != reviewManager.STATUS_COMPLETED){
                        JobIsNotCompleted=true;
                        break;
                    }
                } 
                if(JobIsNotCompleted){
                    Job.addError('Il y a au moins 1 review Not Completed');
                }
            }
        }
    }
    public Map<Id, List<review__c>> initMapReviewByJobId(List<Review__c> listReview){
        
        Map<Id, List<review__c>> mapReviewsByJobId = new Map<Id, List<review__c>>();
        
        for(Review__c R : listReview){
            
            if(mapReviewsByJobId.get(R.Job_Application__c) != null){
                
                mapReviewsByJobId.get(R.Job_Application__c).add(R);
            }
            else{
                mapReviewsByJobId.put(R.Job_Application__c, new list<Review__c>{R});
            }
        } 
        return mapReviewsByJobId;
    }   
}