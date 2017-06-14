Global class OpportunityBatch implements Database.Batchable<sObject>{
    
    String query;
    Date myDate = Date.today();
    Date FinDate = mydate.addDays(7);
    
    
    global Database.QueryLocator Start (Database.BatchableContext bc){
        return Database.getQueryLocator(query);
    }
    global void execute (Database.BatchableContext BC, List <Opportunity> opportunityList){
        for (Opportunity opp : opportunityList){
            
            if(opp.CloseDate == FinDate){
                
                Opportunity opp2 = new Opportunity();
                
                opp2.created_date__c = FinDate.addDays(1);
                
                opportunityList.add(opp2);
                
            } 
            insert opportunityList;
        }
    }
    
    global void finish (Database.BatchableContext BC){
        
    }
    
    
    
}