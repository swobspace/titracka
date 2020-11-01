import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "errorSuccess" ]

  onPostSuccess(event) {
    let [data, status, xhr] = event.detail
    this.errorSuccessTarget.classList.remove("alert", "alert-danger")
    this.errorSuccessTarget.innerText = ""
    if (this.element.classList.contains("modal", "show")) {
       $(this.element).modal("toggle")
       this.element.querySelector('form').reset()
    }
  }
  onPostError(event) {
    let [data, status, xhr] = event.detail
    let error_msg = "ERROR:: " + data.join("; ")
    console.log(error_msg)
    this.errorSuccessTarget.classList.add("alert", "alert-danger")
    this.errorSuccessTarget.innerText = error_msg
  }

}
