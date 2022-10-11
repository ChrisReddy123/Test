public class TransponderRepositoryFactory {
	public ITransponderRepository Create(Vehicle__c vehicle)
    {
        ITransponderRepository transponderRepository;
        
        if(vehicle.Year__c <=  date.Today().year() - 25)
        {
            transponderRepository = new ClassicTransponderRepository();
        }
        else
        {
            transponderRepository = new ModernTransponderRepository();
        }
        return transponderRepository;
    }
}