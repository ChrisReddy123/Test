@isTest
public class VehicleTriggerTest {
	@isTest 
    static void TestClassicTransponderCreation() {
        triggerTransponderCreation('Classic');
    }

    @isTest 
    static void TestModernTransponderCreation() {
        triggerTransponderCreation('Modern');
    }
    
    static void triggerTransponderCreation(string type)
    {
        Vehicle__c vehicle;
        if(type == 'Classic')
        {
        	vehicle = new Vehicle__c(Make__c='Audi', Model__c='A6', Year__c=date.today().Year()-30, Account_Id__c = '0018c00002TT48GAAT', License_Plate_State__c = 'MO', License_Plate_Number__C = 'ABC123');
        }         
        else
        {
            vehicle = new Vehicle__c(Make__c='BMW', Model__c='X5', Year__c=date.today().Year(), Account_Id__c = '0018c00002TT48GABC', License_Plate_State__c = 'MO', License_Plate_Number__C = 'ABC123');
        }

        Test.startTest();
        Database.SaveResult result = Database.insert(vehicle, false);
        Test.stopTest();

        System.assert(result.isSuccess(), 'Error in creating a new vehicle');
        System.assert(result.getErrors().size() == 0, result.getErrors().size() + ' error(s) in creating a new vehicle.');
        
        if(result.isSuccess())
        {
            string vehicleId = result.getId();
        	List<Transponder__c> transponders = [SELECT Id, type__c FROM Transponder__c WHERE vehicle_Id__c = :vehicleId and issue_Date__c = :date.today() and type__c = :type];
            System.assertEquals(1, transponders.size(), 'Expected one transponder but received ' + transponders.size());
        }
    }
}