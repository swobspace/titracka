import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "modalForm", "modalView" ]

  open() {
    let modal_id = this.modalViewTarget.getAttribute("data-modalId")
    let modal_element = document.getElementById(modal_id)

    if (this.hasModalFormTarget) {
      let action_url = this.modalFormTarget.getAttribute('data-actionurl')
      let form = modal_element.querySelector('form')
      form.setAttribute('action', action_url) 
    }

    $(modal_element).modal()
  }
}
