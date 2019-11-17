import { api, track, LightningElement } from 'lwc'
import getIncident from "@salesforce/apex/StatusPageController.getIncident"

export default class systemIncident extends LightningElement {
    @api recordId
    @track incident
    @track updates

    get statusPhrase() {
        switch (this.incident.Status__c) {
            case 'INVESTIGATING':
                return 'We are currently investigating this issue.'
            case 'IDENTIFIED':
                return 'We have identified the issue and we are working to fix it.'
            case 'MONITORING':
                return 'We have fixed the issue and we are currently monitoring the stability of the service.'
            case 'RESOLVED':
                return 'The issue has been resolved.'
            default:
                return ''
        }
    }

    connectedCallback() {
        getIncident({ incidentId: this.recordId }).then(res => {
            this.incident = res
            this.updates = res.IncidentUpdates__r || []
        })
    }
}