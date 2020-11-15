import ApplicationController from './application_controller'
import { Jstree } from 'jstree'

export default class extends ApplicationController {
  static targets = [ "tree" ]

  connect () {
    super.connect()
    let that = this
    $(this.treeTarget).jstree({
      "plugins" : [ "types", "search" ],
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
      }
    })
    $(this.treeTarget).jstree("open_all")
    let org_units = $(this.treeTarget).find('li > a.org_unit')
    org_units.parent('li').each(function(index) {
      $(that.treeTarget).jstree(true).set_type($(this), 'org_unit')
    })
    let lists = $(this.treeTarget).find('li > a.list')
    lists.parent('li').each(function(index) {
      $(that.treeTarget).jstree(true).set_type($(this), 'list')
    })

  }
}
