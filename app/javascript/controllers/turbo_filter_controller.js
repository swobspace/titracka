// app/javascript/controllers/turbo_filter_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["filter"]
  static values = {
    url: String
  }

  connect () {
    this.baseUrl = this.urlValue || `${window.location.pathname}`
    if (this.params().length > 0) {
      this.fetch()
    }
  }

  filter() {
    this.fetch()
  }

  fetch() {
    let url = `${this.urlValue}`
    if (this.params().length > 0 ) {
      url = `${url}?${this.params()}`
    }
    fetch(url, {
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
    .then(r => r.text())
    .then(html => Turbo.renderStreamMessage(html))
  }

  params() {
    let params = new URLSearchParams()
    this.filterTargets.map(function(t) {
      if (t.matches('[type="checkbox"]')) {
        if (t.checked) {
          params.append(t.name, t.value)
        }
      }
      else if (t.value !== '') {
        params.append(t.name, t.value)
      }
    })
    // console.log(`${params}`)
    return `${params}`
  }

  reset() {
    this.element.reset();
  }
}
