import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = ["content"]
  static classes = ["toggle"]

  connect () {
    super.connect()
    // add your code here, if applicable
    this.toggle()
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
