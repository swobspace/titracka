import ApplicationController from './application_controller'
export default class extends ApplicationController {
  static targets = ["content"]
  static classes = ["collapse"]

  connect () {
    super.connect()
    // add your code here, if applicable
  }

  toggle() {
    // this.contentTarget.classList.toggle(this.collapseClass)
    this.contentTargets.forEach((t) => t.classList.toggle(this.collapseClass))
  }

  toggleAll(event) {
    const clapse = this.collapseClass
    const collapse = event.target.classList.contains(clapse)
    
    document.querySelectorAll('[data-toggle-target="content"]').forEach(function(t) {
      if (collapse) {
        t.classList.remove(clapse)
      } else {
        t.classList.add(clapse)
      }
    })
  }

}
