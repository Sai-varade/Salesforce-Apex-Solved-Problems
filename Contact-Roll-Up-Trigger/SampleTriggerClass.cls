public class ContactTriggerHandler {
    
    private Set<Id> accIds = new Set<Id>();
    
    public void afterInsert(List<Contact> newList) {
        task1(newList);
    }
    
    public void afterUpdate(List<Contact> newList, Map<Id, Contact> oldMap) {
        task2(newList, oldMap);
    }
    
    public void afterDelete(List<Contact> oldList) {
        task1(oldList);
    }
    
    public void afterUndelete(List<Contact> newList) {
        task1(newList);
    }
    
    private void task1(List<Contact> newList){
        for(Contact c: newList){
            if(c.AccountId != null){
                accIds.add(c.AccountId);
            }
        }
        if(!accIds.isEmpty()){
            ContactRollUp.CalculateContact(accIds);
        }
    }

    private void task2(List<Contact> newList, Map<Id,Contact> oldmap){
        for(Contact c: newList){
            Id oldId = oldmap.get(c.Id).AccountId;
            if(c.AccountId != oldId){
                if(c.AccountId != null){
                    accIds.add(c.AccountId);
                }
                if(oldId != null){
                    accIds.add(oldId);
                }
            }
        }
        if(!accIds.isEmpty()){
            ContactRollUp.CalculateContact(accIds);
        }
    }
}


