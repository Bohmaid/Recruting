public class JobAppManager {
    
    
    private static String CLASS_NAME = JobAppManager.class.getName();
    private static final String ALL_FIELDS = ObjectUtil.constructFieldListForQueryFrom('Job_Application__c');
    
    public static final String STATUS_COMPLETED     = 'completed';
    public static final String STATUS_rejected     = 'Rejected';
    
    /*-----INSERT-------*/
    public static List<Job_Application__c> insertJobApps(List<Job_Application__c> JobApps) {
        String methodName = 'insertJobApps';
        ObjectUtil.debugLogBegin(CLASS_NAME, methodName , '[JobApps] :' + JobApps);
        
        if (JobApps != null && JobApps.size() > 0) {
            
            insert JobApps;
        }
        
        ObjectUtil.debugLogEnd(CLASS_NAME, methodName , '[RESULTS] :' + JobApps);
        return JobApps;
    }
    /*-----UPDATE-------*/
    public static List<Job_Application__c> updateJobApps(List<Job_Application__c> JobAppsListe){
        
        String methodName = 'updateJobApps';
        ObjectUtil.debugLogBegin(class_Name, methodName,'[JobAppsListe]:' + JobAppsListe);
        if (JobAppsListe != null && JobAppsListe.size()>0){
            update JobAppsListe;
        }
        ObjectUtil.debugLogEnd(class_Name, methodName, '[RESULTS]:' + JobAppsListe);
        return JobAppsListe;
    }
    public static List<Job_Application__c> getListByJobId(set <Id> JobApplidactionIds){
        String methodName='getListByJobId';
        ObjectUtil.debugLogBegin(class_Name, methodName, '[Results]:'+JobApplidactionIds);
        List<Job_Application__c> listJob = new List<Job_Application__c>();
        if (listJob != null && listJob.size()>0){
            String soqlQuery = 'SELECT ' + ALL_FIELDS + ',Position__c,Candidate__c From Job_Application__c WHERE Id IN :JobApplidactionIds';
            listJob = new List<Job_Application__c>((List<Job_Application__c>)Database.query(soqlQuery));
        }
        return listJob;

    }
}