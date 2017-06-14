trigger JobAppTrigger on Job_Application__c (before update) {
    
    
    JobAppTriggerHandler handler= new JobAppTriggerHandler();
    
    if(Trigger.isBefore && Trigger.isUpdate){
        
        handler.onBeforeUpdate(Trigger.new, Trigger.oldMap);
        
    }
    
}