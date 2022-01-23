import { Controller } from "@hotwired/stimulus"
import '../src/jquery.js'
import 'pdfmake'
import dataTable from 'datatables.net-bs5'
dataTable(window, $)
import buttons from 'datatables.net-buttons-bs5'
buttons(window, $)
import columnVisibility from 'datatables.net-buttons/js/buttons.colVis.js'
columnVisibility(window, $)
import buttonsHtml5 from 'datatables.net-buttons/js/buttons.html5.js'
buttonsHtml5(window, $)
import buttonsPrint from 'datatables.net-buttons/js/buttons.print.js'
buttonsPrint(window, $)

import { DataTable } from "datatables.net"

export default class extends Controller {
  static targets = [ "datatable", "remotetable", "plaintable" ]

  initialize() {
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
    if (this.hasDatatableTarget) {
      this.set_input_fields(this.element)
      this.datatableTargets.forEach(table => {
	  let mytable = $(table).DataTable({
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
          mytable.columns().eq(0).each((colIdx) => {
            $('input[name=idx'+colIdx+']').on( 'keyup change', function() {
              mytable.column(colIdx).search(this.value).draw()
            })
          })
        } // table
      ) // forEach
    } // hasDatatableTarget
  } // connect

  set_input_fields(el) {
    el.querySelectorAll('table tfoot th').forEach((th, idx) => {
      th.insertAdjacentHTML('afterbegin', this.search_field(idx))
    })
  }

  search_field(idx) {
    return `<input type="text" placeholder="search" name="idx${idx}" />`
  }
} // Controller
