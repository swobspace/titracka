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
  }

  afterEdit(element) {
    this.openModal(element)
  }

  openModal(element) {
    let modal_id = element.dataset["modalId"]
    let modal_element = document.getElementById(modal_id)
    $(modal_element).modal()
  }

}
