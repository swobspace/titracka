import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "modalForm" ]

  open() {
    let action_url = this.modalFormTarget.getAttribute('data-actionurl')
    let modal_id = this.modalFormTarget.getAttribute("data-modalId")
    let modal_element = document.getElementById(modal_id)
    let form = modal_element.querySelector('form')
    form.setAttribute('action', action_url) 
    $(modal_element).modal()
  }
}
