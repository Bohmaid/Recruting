public class reviewManager {
    
    private static String CLASS_NAME = reviewManager.class.getName();
    
    //Object Name
    private static String OBJECT_NAME = 'review__c';
    
    private static final String ALL_FIELDS = ObjectUtil.constructFieldListForQueryFrom(OBJECT_NAME);
    
    public static final String STATUS_COMPLETED     = '01';
    public static final String STATUS_IN_PROGRESS   = '02';
    
    public static List<Review__c> insertReview(List<Review__c> reviews) {
        String methodName = 'insertReview';
        ObjectUtil.debugLogBegin(CLASS_NAME, methodName , '[reviews] :' + reviews);
        
        if (reviews != null && reviews.size() > 0) {
            insert reviews;
        }
        
        ObjectUtil.debugLogEnd(CLASS_NAME, methodName , '[RESULTS] :' + reviews);
        return reviews;
    }
    public static List<review__c> getListByJobId(Set<Id> JobApplicationsIds) {
        String methodName = 'getListByJobId';
        ObjectUtil.debugLogBegin(CLASS_NAME, methodName , '[JobApplicationsIds] :' + JobApplicationsIds);
        
        List<review__c> JobList = new List<review__c>();
        
        if (JobApplicationsIds != null && JobApplicationsIds.size() > 0) {
            String soqlQuery = 'SELECT ' + ALL_FIELDS + ' FROM review__c WHERE Job_Application__c IN :JobApplicationsIds';
            JobList = new List<review__c>((List<review__c>)Database.query(soqlQuery));
        }
        
        ObjectUtil.debugLogEnd(CLASS_NAME, methodName , '[RESULTS] :' + JobList);
        return JobList;
    }  
    
}