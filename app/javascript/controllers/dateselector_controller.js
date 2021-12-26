/*
  <div data-controller="dateselector" data-dateselector-url="<%= main_app.root_path %>">
    <button class="nav-link btn btn-outline-secondary mr-1" 
            data-dateselector-target="date">
      <i class="far fa-calendar-alt"></i>
    </button>
  </div>

*/ 
import { Controller } from "stimulus"
import flatpickr from "flatpickr"

export default class extends Controller {
  static targets = [ "date" ]

  connect() {
    const url = this.data.get("url")
    flatpickr(this.dateTarget, {
      defaultDate: new Date(),
      dateFormat: "Y-m-d",
      onChange: function(selectedDates, dateStr, instance) {
        let newurl = url + dateStr
        Turbolinks.clearCache();
        Turbolinks.visit(newurl);
      }
    })
  }
}
