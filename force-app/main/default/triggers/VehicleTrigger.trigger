trigger VehicleTrigger on Vehicle__c (after insert) {

    if( Trigger.isInsert && Trigger.isAfter )
    {
        VehicleTriggerHandler.afterInsert(trigger.New);
    }
   
}