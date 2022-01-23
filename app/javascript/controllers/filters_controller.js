// filters_controller.js
// idea from https://boringrails.com/articles/better-stimulus-controllers/
//
import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = ["filter"]
  static values = {
    url: String
  }

  connect () {
    super.connect()
    this.baseUrl = this.urlValue || `${window.location.pathname}`
  }

  filter() {
    const url = `${this.baseUrl}?${this.params}`
    Turbo.clearCache()
    Turbo.visit(url)
  }

  reset() {
    Turbo.clearCache()
    Turbo.visit(this.baseUrl)
  }


  get params() {
    // console.log(this.filterTargets.map((t) => `${t.name}=${t.value}`).join("&"))
    return this.filterTargets.map(function(t) {
      // return only params.present?
      if (t.matches('[type="checkbox"]')) {
        if (t.checked) {
          return `${t.name}=${t.value}`
        } else {
          return ''
        }
      } 
      else if (t.value !== '') {
        return `${t.name}=${t.value}`
      } else {
        return ''
      }
    }).filter(String).join("&")
 }

}
