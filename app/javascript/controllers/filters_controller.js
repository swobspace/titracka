import ApplicationController from './application_controller'
export default class extends ApplicationController {
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

  get params() {
    return this.filterTargets.map(function(t) {
      // return only params.present?
      if (t.value !== '') {
        return `${t.name}=${t.value}`
      } else {
        return ''
      }
    }).filter(String).join("&");
  }
}
