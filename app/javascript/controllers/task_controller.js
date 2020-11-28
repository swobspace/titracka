import ApplicationController from './application_controller'

export default class extends ApplicationController {

  connect () {
    super.connect()
    // add your code here, if applicable
  }

  afterShow(element) {
    this.openModal(element)
  }

  afterNew(element) {
    this.openModal(element)
    this.modalElement(element)
        .querySelectorAll("[data-controller='select2']")
        .forEach((s) =>  s.select2.connect())
  }

  afterEdit(element) {
    this.openModal(element)
    this.modalElement(element)
        .querySelectorAll("[data-controller='select2']")
        .forEach((s) =>  s.select2.connect())
  }

  openModal(element) {
    $(this.modalElement(element)).modal()
  }

  modalElement(element) {
    let modal_id = element.dataset["modalId"]
    return document.getElementById(modal_id)
  }
}
