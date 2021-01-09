import ApplicationController from './application_controller'
export default class extends ApplicationController {
  static targets = ["content"]
  static classes = ["toggle"]

  connect () {
    super.connect()
    // add your code here, if applicable
  }

  toggle() {
    // this.contentTarget.classList.toggle(this.toggleClass)
    this.contentTargets.forEach((t) => t.classList.toggle(this.toggleClass))
  }

  toggleAll(event) {
    const tclass = this.toggleClass
    const applied = event.target.classList.contains(tclass)
    
    this.element.querySelectorAll('[data-toggle-target="content"]').forEach(function(t) {
      if (applied) {
        t.classList.remove(tclass)
      } else {
        t.classList.add(tclass)
      }
    })
  }

}
