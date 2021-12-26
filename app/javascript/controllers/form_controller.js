import { Controller } from "stimulus"
import '../src/jquery.js'

export default class extends Controller {
  static targets = [ "errorSuccess" ]

  connect () {
  }
  onPostSuccess(event) {
    const render_root = this.data.get('renderRoot')
    const render_url = document.getElementById(render_root).dataset['url']
    let [data, status, xhr] = event.detail
    this.errorSuccessTarget.classList.remove("alert", "alert-danger")
    this.errorSuccessTarget.innerText = ""
    if (this.element.classList.contains("modal", "show")) {
       $(this.element).modal("toggle")
       this.element.querySelector('form').reset()
    }
    Turbo.visit(render_url)
  }
  onPostError(event) {
    let [data, status, xhr] = event.detail
    let error_msg = "ERROR:: " + data.join("; ")
    this.errorSuccessTarget.classList.add("alert", "alert-danger")
    this.errorSuccessTarget.innerText = error_msg
  }

}
