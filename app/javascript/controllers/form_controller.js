import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static targets = [ "errorSuccess" ]

  connect () {
    const render_root = this.data.get('renderRoot')
    const render_url = document.getElementById(render_root).dataset['url']
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
    Turbolinks.visit(render_url)
  }
  onPostError(event) {
    let [data, status, xhr] = event.detail
    let error_msg = "ERROR:: " + data.join("; ")
    this.errorSuccessTarget.classList.add("alert", "alert-danger")
    this.errorSuccessTarget.innerText = error_msg
  }

}
