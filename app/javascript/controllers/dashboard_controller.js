import { Controller } from "stimulus"
import '../src/jquery.js'
import jstree from 'jstree'


export default class extends Controller {
  static targets = [ "tree" ]

  initialize() {
    $.jstree.defaults.core.themes.url = false
  }

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
    let lists = $(this.treeTarget).find('li > a.list, li > a.list_decorator')
    lists.parent('li').each(function(index) {
      $(that.treeTarget).jstree(true).set_type($(this), 'list')
    })
  }

  open(event) {
    let url = event.target.attributes.href.value
    Turbo.visit(url)
  }

}
