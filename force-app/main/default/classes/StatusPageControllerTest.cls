@IsTest
private class StatusPageControllerTest {

    @IsTest
    static void test_getAllSystems() {
        System__c sys = new System__c(
            Name = 'The Sys',
            Status__c = 'UNAVAILABLE'
        );
        insert sys;

        Test.startTest();
        List<System__c> systems = StatusPageController.getAllSystems();
        Test.stopTest();

        System.assertNotEquals(0, systems.size(), 'Should have retrieved the inserted system record.');
    }

    @IsTest
    static void test_getIncident() {
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

        Test.startTest();
        incident = StatusPageController.getIncident(incident.Id);
        Test.stopTest();

        System.assertNotEquals(null, incident, 'Should have retrieved the inserted incident.');
    }
}
