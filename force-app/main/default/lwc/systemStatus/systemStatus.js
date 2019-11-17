import { api, track, LightningElement } from 'lwc';

export default class systemStatus extends LightningElement {

    @api system
    @track incidents

    get statusIcon() {
        switch (this.system.Status__c) {
            case 'UNAVAILABLE':
                return 'utility:clear'
            case 'PERFORMANCE_DEGRADATION':
                return 'utility:warning'
            default:
                return 'utility:success'
        }
    }

    get statusMessage() {
        switch (this.system.Status__c) {
            case 'UNAVAILABLE':
                return 'Unavailable'
            case 'PERFORMANCE_DEGRADATION':
                return 'Performance degradation'
            default:
                return 'Operational'
        }
    }

    get variant() {
        switch (this.system.Status__c) {
            case 'UNAVAILABLE':
                return 'error'
            case 'PERFORMANCE_DEGRADATION':
                return 'warning'
            default:
                return 'success'
        }
    }

    get statusTextVariant() {
        switch (this.system.Status__c) {
            case 'UNAVAILABLE':
                return 'slds-text-color_error'
            case 'PERFORMANCE_DEGRADATION':
                return 'slds-text-color_default'
            default:
                return 'slds-text-color_success'
        }
    }

    get hasIncidents() {
        return this.system.Incidents__r !== undefined && this.system.Incidents__r.length > 0
    }
}