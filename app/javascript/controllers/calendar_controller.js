import { Controller } from "@hotwired/stimulus"
import { Calendar } from '@fullcalendar/core'
import interactionPlugin from '@fullcalendar/interaction'
import multiMonthPlugin from '@fullcalendar/multimonth'
import dayGridPlugin from '@fullcalendar/daygrid'
import deLocale from '@fullcalendar/core/locales/de'
import bootstrap5Plugin from '@fullcalendar/bootstrap5';

export default class extends Controller {
  static values = {
    url: String
  }

  connect() {
    this.initializeCalendar()
  }

  disconnect() {
    this.calendar.destroy()
  }

  initializeCalendar() {
    let _this = this
    this.calendar = new Calendar(this.element, {
      plugins: [interactionPlugin, dayGridPlugin, multiMonthPlugin, bootstrap5Plugin],
      eventBackgroundColor: '#176775',
      selectable: true,
      initialView: 'dayGridMonth',
      multiMonthMaxColumns: 3,
      fixedWeekCount: false,
      events: '/workdays.json',
      defaultAllDay: true,
      weekNumbers: false,
      firstDay: 1,
      locale: deLocale,
      headerToolbar: {
        right: 'prev,next today dayGridMonth,multiMonthYear',
        center: 'title',
        left: ''
      },
      views: {
        dayGrid: {},
        multiMonthYear: {}
      },
      dateClick: function(info) {
        console.log('Clicked on: ' + info.dateStr)
        console.log('Coordinates: ' + info.jsEvent.pageX + ',' + info.jsEvent.pageY)
        console.log('Current view: ' + info.view.type)
        // change the day's background color just for fun
        // info.dayEl.style.backgroundColor = 'red';
        let url = [ _this.urlValue, info.dateStr ].join("/")
        window.open(url, '_self')
      }
    })
    this.calendar.render()
  }
}
