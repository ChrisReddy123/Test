@isTest
public class ModernTransponderRepositoryTest {
	@isTest 
    static void TestTransponderCreation() {
        Vehicle__c vehicle = new Vehicle__c(Make__c='Audi', Model__c='A6', Year__c=Date.today().year(), Account_Id__c = '0018c00002TT48GAAT', License_Plate_State__c = 'MO', License_Plate_Number__C = 'ABC123');
		//This flag is set so as to skip the trigger execution.
		//Since this test tests the transponder creation functionality by itself, we do not want the trigger to fire as it creates a second transponder record
        VehicleTriggerHandler.skipTrigger = true;
        
        Test.startTest();
        Database.SaveResult result = Database.insert(vehicle, false);
        Test.stopTest();

        System.assert(result.isSuccess(), 'Error in creating a new vehicle');
        System.assert(result.getErrors().size() == 0, result.getErrors().size() + ' error(s) in creating a new vehicle');
        
        if(result.isSuccess())
        {
            string vehicleId = result.getId();
            new ModernTransponderRepository().CreateTransponder(vehicle);
        	List<Transponder__c> transponders = [SELECT Id FROM Transponder__c WHERE vehicle_Id__c = :vehicleId and issue_Date__c = :date.today() and type__c = 'Modern'];
            System.assertEquals(1, transponders.size(), 'Expected one transponder but received ' + transponders.size());
        }
    }
}