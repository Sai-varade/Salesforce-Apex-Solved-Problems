public class ContactRollUp {

    public static void CalculateContact(Set<Id> accIds){
        
        if(accIds.isEmpty()) return ;

        List<AggregateResult> contactCount = [Select AccountId accId, count(Id) cCount from Contact Where AccountId In :accIds Group By AccountId];
        
        Map<Id,Integer> count = new Map<Id,Integer>();

        for(AggregateResult ar : contactCount){
            count.put((Id)ar.get('accId'),Integer.valueOf(ar.get('cCount')));
        }

        List<Account> accList = [Select Id, Number_of_Contacts__c from Account Where Id IN :accIds];

        for(Account a : accList){
            a.Number_of_Contacts__c = count.get(a.Id) != null ? count.get(a.Id) : 0;
        }
        update accList;
    }
}