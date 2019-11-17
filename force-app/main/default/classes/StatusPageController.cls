public without sharing class StatusPageController {

    @AuraEnabled
    public static List<System__c> getAllSystems() {
        return [SELECT
            Id,
            Name,
            Status__c,
            (
                SELECT
                Id
                FROM Incidents__r
                WHERE Status__c != 'RESOLVED'
                ORDER BY IncidentStartDateTime__c
            )
            FROM System__c
        ];
    }

    @AuraEnabled
    public static Incident__c getIncident(Id incidentId) {
        return [SELECT
            Id,
            Name,
            Description__c,
            IncidentStartDateTime__c,
            IncidentEndDateTime__c,
            Status__c,
            (
                SELECT
                Id,
                Description__c,
                CreatedDate
                FROM IncidentUpdates__r
            )
            FROM Incident__c
            WHERE Id = :incidentId
        ];
    }
}
