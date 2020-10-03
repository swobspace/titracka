import { Controller } from "stimulus"

import { DataTable } from "datatables.net"

export default class extends Controller {
  static targets = [ "datatable", "remotetable", "plaintable" ]

  initialize() {
    // console.log("datatable controller initialized")
    var myTable = $.fn.dataTable;
    $.extend( true, myTable.Buttons.defaults, {
      "dom": {
        "button": {
          "className": 'btn btn-outline-secondary btn-sm'
        }
      }
    });
  }

  connect() {
    // console.log("datatable controller connected")
    if (this.hasDatatableTarget) {
      this.datatableTargets.forEach(table => {
	  $(table).DataTable({
	    "pagingType": "full_numbers",
	    "dom": "<'row'<'col-md-3'l><'col-md-5'BC><'col-md-4'f>>t<'row'<'col-md-6'ir><'col-md-6'p>>",
	    "stateSave": false,
	    "lengthMenu": [ [10, 25, 100, 250, 1000], [10, 25, 100, 250, 1000] ],
	    "buttons": [
	      { 
		"extend": 'copy',
		"className": 'btn-outline-secondary btn-sm',
		"exportOptions": {
		  "columns": ':visible',
		  "search": ':applied'
		}
	      },
	      { 
		"extend": 'excelHtml5',
		 // "title": $('table[role="datatable"]').data('title'),
		"className": 'btn-outline-secondary btn-sm',
		"exportOptions": {
		  "search": ':applied'
		}
	      },
	      { 
		"extend": 'pdf',
		"className": 'btn-outline-secondary btn-sm',
		"orientation": 'landscape',
		"pageSize": 'A4',
		"exportOptions": {
		  "columns": ':visible',
		  "search": ':applied'
		}
	      },
	      { 
		"extend": 'print',
		"className": 'btn-outline-secondary btn-sm',
	      },
	      { 
		"extend": 'colvis',
		"className": 'btn-outline-secondary btn-sm',
		// "text": "<%= I18n.t('titracka.change_columns') %>",
		"columns": ':gt(0)'
	      }
	    ],
	    "columnDefs": [
	      { "targets": "nosort", "orderable": false },
	      { "targets": "notvisible", "visible": false }
	    ]
	  }) // .DataTable()
        } // table
      ) // forEach
    } // hasDatatableTarget
  } // connect
} // Controller
