import { Controller } from "stimulus"
import '../src/jquery.js'

export default class extends Controller {

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
