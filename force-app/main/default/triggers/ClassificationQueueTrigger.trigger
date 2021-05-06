trigger ClassificationQueueTrigger on Case (before insert, before update) {

    Id g1 = [SELECT Id FROM Group WHERE Type = 'Queue' AND DeveloperName = 'Atendimento_N1'].Id;       
    Id g2 = [SELECT Id FROM Group WHERE Type = 'Queue' AND DeveloperName = 'Atendimento_N2'].Id;   
    Id g3 = [SELECT Id FROM Group WHERE Type = 'Queue' AND DeveloperName = 'Atendimento_N3'].Id;

    for (Case c : Trigger.New) {
        
        if (Trigger.isInsert && Trigger.isBefore) {
            if (c.Classification__c == 'Problema 1'){
               c.OwnerId = g1;
               c.Update_to_Service_N1__c = DateTime.now();
            } 
        }
        
    	if (Trigger.isUpdate && Trigger.isBefore) {
            if (c.Classification__c == 'Problema 1') {
               c.OwnerId = g1;
               c.Update_to_Service_N1__c = DateTime.now();
            } else if (c.Classification__c == 'Problema 2') {
               c.OwnerId = g2;
               c.Update_to_Service_N2__c = DateTime.now();
            } else if (c.Classification__c == 'Problema 3') {
               c.OwnerId = g3;
               c.Update_to_Service_N3__c = DateTime.now();
            }
    	}
        
    }

}