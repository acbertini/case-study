@isTest
public class TesQueueValidation {
    
    @isTest static void TestCreateCase() {
        Case c = new Case(Description='Teste Problema N1');
        insert c;
        
        c.Status = 'Closed';
        update c;
    }
    
    @isTest static void TestUpdateCaseToN2() {
        Case c = new Case(Description='Teste Problema N3');
        insert c;
        
        c.Classification__c = 'Problema 2';
        update c;
        
        c.Status = 'Closed';
        update c;
    }
    
    @isTest static void TestUpdateCaseToN3() {
        Case c = new Case(Description='Teste Problema N3');
        insert c;
        
        c.Classification__c = 'Problema 3';
        update c;
   
        c.Status = 'Closed';
        update c;
    }
    
    @isTest static void TestCreateCaseN1toN2() {
        Case c = new Case(Description='Teste Problema N1 to N2');
        insert c;
        
        c.Classification__c = 'Problema 2';
        update c;
        
        c.Status = 'Closed';
        update c;
    }
    
    @isTest static void TestCreateCaseN1toN3() {
        Case c = new Case(Description='Teste Problema N1 to N3');
        insert c;
        
        c.Classification__c = 'Problema 3';
        update c;
        
        c.Status = 'Closed';
        update c;
    }
    
        @isTest static void TestCreateCaseN1toN2toN3() {
        Case c = new Case(Description='Teste Problema N1 to N2 to N3');
        insert c;
        
        c.Classification__c = 'Problema 2';
        update c;
            
        c.Classification__c = 'Problema 3';
        update c;
        
        c.Status = 'Closed';
        update c;
    }

}