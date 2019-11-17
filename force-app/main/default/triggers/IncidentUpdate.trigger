trigger IncidentUpdate on IncidentUpdate__c (after insert) {
    Map<Id, Incident__c> incidents = new Map<Id, Incident__c>();
    Map<Id, System__c> systems = new Map<Id, System__c>();
    for (IncidentUpdate__c record : Trigger.new) {
        if (String.isNotEmpty(record.IncidentStatusUpdate__c)) {
            incidents.put(record.Incident__c, new Incident__c(
                Id = record.Incident__c,
                Status__c = record.IncidentStatusUpdate__c
            ));
        }
        if (String.isNotEmpty(record.SystemStatusUpdate__c)) {
            systems.put(record.SystemId__c, new System__c(
                Id = record.SystemId__c,
                Status__c = record.SystemStatusUpdate__c
            ));
        }
    }
    update incidents.values();
    update systems.values();
}