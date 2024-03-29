import { Controller } from "@hotwired/stimulus"

import '../src/jquery.js'

import select2 from 'select2'
select2(window, $)

export default class extends Controller {
  static targets = [ "input" ]

  initialize() {
    $.fn.select2.defaults.set( "theme", "bootstrap-5" )
    this.element[this.identifier] = this

    const delegate = function (eventName, parameters) {
      const handler = (...args) => {
	const data = {}
	parameters.forEach((name, i) => data[name] = args[i]);
	const delegatedEvent = new CustomEvent("jquery:" + eventName, {
	    bubbles: true,
	    cancelable: true,
	    detail: data
	  }
	)
	data.event.target.dispatchEvent(delegatedEvent)
	// console.log(delegatedEvent);
      }
      $(document).on(eventName, handler)
    }
    delegate('change', ['event'])
  }


  connect() {
    // console.log(this.inputTarget)
    if (this.hasInputTarget) {
      $(this.inputTargets).select2({
        'width': '100%',
        'language': 'de'
      })
    }
  }

}
