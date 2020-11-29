import { Controller } from "stimulus"
import * as Pikaday  from "pikaday"

export default class extends Controller {
  static targets = [ "date", "field" ]

  connect() {
    // const url = this.data.get("url")
    const url = this.data.get("url")
    let picker = new Pikaday({
      field: this.fieldTarget,
      trigger: this.dateTarget,
      format: 'YYYY-MM-DD',
      onSelect: function(date) {
        let value = picker.toString()
        let newurl = url + value
        // console.log(newurl)
        Turbolinks.clearCache();
        Turbolinks.visit(newurl);
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
    // console.log("clicked")
  }
}
