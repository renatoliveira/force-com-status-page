import { track, LightningElement } from 'lwc'
import getAllSystems from "@salesforce/apex/StatusPageController.getAllSystems"

export default class statusComponent extends LightningElement {

    @track systems = []

    connectedCallback() {
        getAllSystems().then(res => {
            this.systems = res
        })
    }
}