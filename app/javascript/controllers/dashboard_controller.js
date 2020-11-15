import ApplicationController from './application_controller'
import { Jstree } from 'jstree'

export default class extends ApplicationController {
  static targets = [ "tree" ]

  connect () {
    super.connect()
    $(this.treeTarget).jstree({
      "plugins" : [ "types", "search" ],
      "core": {
        'check_callback': true
      },
      "types": {
	"default": {
	  "icon": "fas fa-users fa-xs",
	  "li_attr": {
	    "class": 'nav-item'
	  }
	},
	"list": {
	  "icon": "far fa-list fa-fw",
	  "li_attr": {
	    "class": 'nav-item'
	  }
	}
      }
    })
    $(this.treeTarget).jstree("open_all")
  }
}
