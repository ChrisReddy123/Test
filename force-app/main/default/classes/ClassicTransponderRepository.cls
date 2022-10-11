public with sharing class ClassicTransponderRepository implements ITransponderRepository {
	public Transponder__c CreateTransponder(Vehicle__c vehicle)
    {
        Transponder__c transponder = new Transponder__c();
        transponder.Issue_Date__c = date.today();
        transponder.Vehicle_Id__c = vehicle.Id;
        transponder.Type__c = 'Classic';
        insert transponder;
        return transponder;
    }
}