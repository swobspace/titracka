import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "timeAccounting" ]

  initialize() {}
  connect() {
    if (this.hasTimeAccountingTarget) {

    }
  }
  disconnect() {}

  add_activity() {
    let activities_url = this.timeAccountingTarget.getAttribute('data-activities-url')
    let form = document.getElementById('timeAccountingModal').querySelector('form')
    form.setAttribute('action', activities_url) 
    $('#timeAccountingModal').modal()
  }
}
