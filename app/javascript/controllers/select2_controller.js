import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "input" ]

  initialize() {
    $.fn.select2.defaults.set( "theme", "bootstrap" )
    this.element[this.identifier] = this
  }


  connect() {
    // console.log(this.inputTarget)
    $(this.inputTarget).select2({
      'width': '100%',
      'language': 'de'
    })
  }
}
