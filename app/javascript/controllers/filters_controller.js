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
    return this.filterTargets.map((t) => `${t.name}=${t.value}`).join("&");
  }
}
