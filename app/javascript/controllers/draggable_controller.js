// javascript/controllers/draggable_controller.js
import { Controller } from 'stimulus'
import { Sortable } from '@shopify/draggable'

export default class extends Controller {
  static targets = ['column', 'task']
  initialize() {}
  connect() {
    if (this.hasTaskTarget) {
      this.taskTargets.forEach(task => {
        task.setAttribute('style', 'z-index: 100;')
      })
      const sortable = new Sortable(this.columnTargets, {
        draggable: 'div.list-group-item',
        distance: 5
      })
      sortable.on('sortable:start', function(event) {
        let task = event.dragEvent.source
        task.setAttribute('style', 'z-index: 1000; background-color: #FFFFAB;')
      })
      sortable.on('sortable:stop', function(event) {
        let url = event.dragEvent.source.getAttribute('data-url')
        let column = event.newContainer.getAttribute('data-id')
        let data = { task: { state_id: column } }
        let token = document.head.querySelector('meta[name="csrf-token"]').getAttribute('content')
        fetch(url, {
          method: 'PUT',
          credentials: 'same-origin',
          headers: {
            "X-CSRF-Token": token,
            "Accept": "application/json",
            "Content-type": "application/json"
          },
          body: JSON.stringify(data)
        })
      })
    }
  }
  disconnect() {}
}
