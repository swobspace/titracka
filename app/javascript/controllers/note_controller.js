import ApplicationController from './application_controller'
import '../src/jquery.js'

export default class extends ApplicationController {

  connect () {
    super.connect()
    // add your code here, if applicable
  }
 afterNew(element) {
    console.log(element)
    this.openModal(element)
  }

  afterEdit(element) {
    this.openModal(element)
  }

  // internal
  openModal(element) {
    $(this.modalElement(element)).modal()
  }

  modalElement(element) {
    let modal_id = element.dataset["modalId"]
    return document.getElementById(modal_id)
  }
}
