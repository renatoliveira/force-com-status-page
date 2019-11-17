@IsTest
private class IncidentUpdateTest {

    @IsTest
    static void testIncidentTrigger() {
        System__c sys = new System__c(
            Name = 'The Sys',
            Status__c = 'UNAVAILABLE'
        );
        insert sys;

        Incident__c incident = new Incident__c(
            System__c = sys.Id,
            IncidentStartDateTime__c = Datetime.now().addHours(-2),
            Description__c = '<p>Lorem ipsum.</p>',
            Status__c = 'INVESTIGATING'
        );
        insert incident;

        IncidentUpdate__c incidentUpdate = new IncidentUpdate__c(
            Incident__c = incident.Id,
            Description__c = '<p>This closes the incident. All is green!</p>',
            IncidentStatusUpdate__c = 'RESOLVED',
            SystemStatusUpdate__c = 'OPERATIONAL'
        );

        Test.startTest();
        insert incidentUpdate;
        Test.stopTest();

        incident = [SELECT Id, System__r.Status__c, Status__c FROM Incident__c WHERE Id = :incident.Id];

        System.assertEquals(incident.Status__c, 'RESOLVED', 'Should have updated the incident status to "resolved"!');
        System.assertEquals(incident.System__r.Status__c, 'OPERATIONAL', 'Should have updated the system status to "operational".');
    }
}
