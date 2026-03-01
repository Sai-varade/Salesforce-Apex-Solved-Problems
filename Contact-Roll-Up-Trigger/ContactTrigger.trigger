trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {
    
    ContactTriggerHandler handler =new ContactTriggerHandler();
    
    switch on Trigger.operationType{
        
        when AFTER_INSERT{
            
            handler.afterInsert(Trigger.new);
        }
        when AFTER_UPDATE{
            
            handler.afterUpdate(Trigger.new,Trigger.oldMap);
        }
        when AFTER_DELETE{
            
            handler.afterDelete(Trigger.old);
        }
        when AFTER_UNDELETE{
            
            handler.afterUndelete(Trigger.new);
        }
    }
}
