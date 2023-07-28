import { Controller } from "@hotwired/stimulus"
import '../src/jquery.js'
import jstree from 'jstree'

export default class extends Controller {
  initialize() {
    $.jstree.defaults.core.themes.url = false
  }

  connect () {
    super.connect()
    let that = this
    $(this.element).jstree({
      "plugins" : [ "contextmenu", "types", "search" ],
      "core": {
        'check_callback': true
      },
      "types": {
	"default": {
	  "icon": "far fa-folder fa-xs",
	  "li_attr": {
	    "class": 'nav-item'
	  }
	},
	"org_unit": {
	  "icon": "fas fa-users fa-xs",
	  "li_attr": {
	    "class": 'nav-item'
	  }
	},
	"list": {
	  "icon": "fas fa-list-ul fa-xs",
	  "li_attr": {
	    "class": 'nav-item'
	  }
	}
      },
      "contextmenu": {
        "items": {
          'cardboard': {
            "separator_before": false,
            "separator_after": false,
            "icon": "fas fa-clipboard-list fw",
            "label": "Cardboard",
            "action": function(obj) {
              let url = obj.reference[0].dataset.url
              window.open(url, '_self')
            }
          },
          'list': {
            "separator_before": false,
            "separator_after": false,
            "icon": "fas fa-th-list fw",
            "label": "List",
            "action": function(obj) {
              let url = obj.reference[0].dataset.url + '/tasks?view=list'
              window.open(url, '_self')
            }
          }
        }
      }
    })
    $(this.element).jstree("open_all")
    let org_units = $(this.element).find('li > a.org_unit')
    org_units.parent('li').each(function(index) {
      $(that.element).jstree(true).set_type($(this), 'org_unit')
    })
    let lists = $(this.element).find('li > a.list, li > a.list_decorator')
    lists.parent('li').each(function(index) {
      $(that.element).jstree(true).set_type($(this), 'list')
    })
  }

  open(event) {
    let url = event.target.attributes.href.value
    Turbo.visit(url)
  }

}
