trigger UpdateServiceTrigger on Case (before update) {

	BusinessHoursService bh = new BusinessHoursService();
    
    for (Case c : Trigger.New) {
        
        if (Trigger.isUpdate && c.IsClosed == true) {
			//Total de horas de atendimento
            Long diffBHTotal = bh.businessHourTimeDifference(c.CreatedDate, c.ClosedDate);    
            String total = bh.diffToString(diffBHTotal);
            c.Total_Service_Time__c = total;   
            
            //Caso aberto e encerrado como N1
            if (c.Classification__c == 'Problema 1') {
                Long diffBH = bh.businessHourTimeDifference(c.Update_to_Service_N1__c, c.ClosedDate);    
                String totalN1 = bh.diffToString(diffBH);
                c.Service_Time_N1__c = totalN1;
            } else if (c.Classification__c == 'Problema 2') { 
                //Caso aberto como N1, alterado e encerrado como N2
                Long diffBH = bh.businessHourTimeDifference(c.Update_to_Service_N2__c, c.Update_to_Service_N1__c);    
                String totalN2 = bh.diffToString(diffBH);
                c.Service_Time_N2__c = totalN2;
            } else if (c.Classification__c == 'Problema 3') {
                if (c.Update_to_Service_N1__c != null && c.Update_to_Service_N2__c == null) {
                    //Caso aberto como N1, alterado para N3 e fechado como N3
                    Long diffBH = bh.businessHourTimeDifference(c.Update_to_Service_N3__c, c.Update_to_Service_N1__c);    
                	String totalN3 = bh.diffToString(diffBH);
                	c.Service_Time_N3__c = totalN3;
                } else if (c.Update_to_Service_N2__c != null) { 
                    //Caso aberto como N1, alterado para N2 e depois para N3 - encerrado como N3
                    Long diffBH = bh.businessHourTimeDifference(c.Update_to_Service_N3__c, c.Update_to_Service_N2__c);    
                	String totalN3 = bh.diffToString(diffBH);
                	c.Service_Time_N3__c = totalN3;
                }        
            }
    	}
        
        if (Trigger.isBefore && c.IsClosed == false) {        
            if (c.Classification__c == 'Problema 1') {
                Long diffBH = bh.businessHourTimeDifference(c.CreatedDate, c.Update_to_Service_N1__c);    
                String totalN1 = bh.diffToString(diffBH);
                c.Service_Time_N1__c = totalN1;
            } else if (c.Classification__c == 'Problema 2') {
                Long diffBH = bh.businessHourTimeDifference(c.CreatedDate, c.Update_to_Service_N2__c);    
                String totalN2 = bh.diffToString(diffBH);
                c.Service_Time_N2__c = totalN2;
            } else if (c.Classification__c == 'Problema 3') {
                if (c.Update_to_Service_N2__c != null) {
                    Long diffBH = bh.businessHourTimeDifference(c.Update_to_Service_N2__c, c.Update_to_Service_N3__c);    
                    String totalN3 = bh.diffToString(diffBH);
                    c.Service_Time_N3__c = totalN3;
                } else if (c.Update_to_Service_N1__c != null) {
                    Long diffBH = bh.businessHourTimeDifference(c.Update_to_Service_N1__c, c.Update_to_Service_N3__c);    
                    String totalN3 = bh.diffToString(diffBH);
                    c.Service_Time_N3__c = totalN3;
                }
            }
            
        }
    }
    
}