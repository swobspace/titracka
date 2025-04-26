import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  // auto-open modal on connect
  connect() {
    console.log("modal#connect")
    this.modal = new bootstrap.Modal(this.element)
    this.modal.show()
    this.element.addEventListener('hidden.bs.modal', this.closeCleanup)
  }

  disconnect() {
    console.log("modal#disconnect")
    this.element.removeEventListener('hidden.bs.modal', this.closeCleanup)
  }

  close() {
    console.log("modal#close")
    this.modal.hide()
  }

  closeCleanup(event) {
    event.target.parentElement.removeAttribute('src')
    event.target.remove()
  }

  // catch turbo:submit-end via action
  handleSubmit = (event) => {
    console.log("modal#handleSubmit")
    // close modal if form submission is successful
    if (event.detail.success) {
      console.log("modal#handleSubmit event successful")
    }
    this.close()
  }

}
