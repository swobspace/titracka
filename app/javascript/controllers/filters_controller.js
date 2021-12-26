// filters_controller.js
// idea from https://boringrails.com/articles/better-stimulus-controllers/
//
import { Controller } from "stimulus"
export default class extends Controller {
  static targets = ["filter"]

  connect () {
    super.connect()
    // add your code here, if applicable
  }

  filter() {
    const url = `${window.location.pathname}?${this.params}`;
    Turbolinks.clearCache();
    Turbolinks.visit(url);
  }

  reset() {
    const url = `${window.location.pathname}`;
    Turbolinks.clearCache();
    Turbolinks.visit(url);
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
    }).filter(String).join("&");
  }
}
