import { Controller } from "stimulus"
import * as Pikaday  from "pikaday"

export default class extends Controller {
  static targets = [ "dateinput" ]

  connect() {
    // console.log(this.dateinputTarget)
    var picker = new Pikaday({
      field: this.dateinputTarget,
      format: 'YYYY-MM-DD',
      firstDay: 1,
      i18n: {
	previousMonth : 'Vorheriger Monat',
	nextMonth     : 'Nächster Monat',
	months        : ['Januar','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'],
	weekdays      : ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
	weekdaysShort : ['So','Mo','Di','Mi','Do','Fr','Sa']
      }
    })
  }
}
