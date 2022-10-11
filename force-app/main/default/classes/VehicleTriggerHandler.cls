public with sharing class VehicleTriggerHandler {

    //This flag is set in ClassicTransponderRepositoryTest and ModernTransponderRepositoryTest
    //to avoid the trigger from creating a duplicate transponder record.
    //This will let us test the CreateTransponder method in both ClassicTransponderRepository and ModernTransponderRepository individually
    @TestVisible static Boolean skipTrigger = false;
    
    public static void afterInsert(List<Vehicle__c> vehicles)
    {
        if(skipTrigger) return;
        for(Vehicle__c vehicle: vehicles)
        {
        	ITransponderRepository transponderRepository = new TransponderRepositoryFactory().Create(vehicle);
        	transponderRepository.CreateTransponder(vehicle);
        }
        
    }
}