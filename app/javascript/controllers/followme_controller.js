import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    url: String
  }
  connect() {
    console.log("followme connected")
  }

  follow() {
    console.log(`followme#follow clicked ${this.urlValue}`)
    Turbo.visit(this.urlValue)
  }
}
