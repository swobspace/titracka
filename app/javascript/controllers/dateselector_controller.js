import { Controller } from "stimulus"
import * as Pikaday  from "pikaday"

export default class extends Controller {
  static targets = [ "date", "field" ]

  connect() {
    var picker = new Pikaday({
      field: this.fieldTarget,
      trigger: this.dateTarget,
      format: 'YYYY-MM-DD',
      onSelect: function(date) {
        var value = picker.toString()
        console.log(value)
      },
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

  set_date(event) {
    console.log("clicked")
  }
}
