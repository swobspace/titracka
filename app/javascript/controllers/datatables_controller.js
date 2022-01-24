import { Controller } from "@hotwired/stimulus"

// jQuery and esbuild are not the best friends
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

// here comes the controller ...
export default class extends Controller {
  static targets = [ "datatable", "remotetable", "plaintable" ]

  initialize() {
    var myTable = $.fn.dataTable;
    $.extend( true, myTable.Buttons.defaults, {
      "dom": { "button": { "className": 'btn btn-outline-secondary btn-sm' } }
    })
  }

  connect() {
    if (this.hasDatatableTarget) {
      this.set_input_fields()
      this.datatableTargets.forEach(table => {
	  let mytable = $(table).DataTable(this.dt_options())
          mytable.columns().eq(0).each((colIdx) => {
            $('input[name=idx'+colIdx+']').on( 'keyup change', function() {
              mytable.column(colIdx).search(this.value).draw()
            })
          })
        } // table
      ) // forEach
    } // hasDatatableTarget
  } // connect

  // search fields for each column
  set_input_fields() {
    this.element.querySelectorAll('table tfoot th').forEach((th, idx) => {
      th.insertAdjacentHTML('afterbegin', this.search_field(idx))
    })
  }

  // single search input field
  search_field(idx) {
    return `<input type="text" placeholder="search" name="idx${idx}" />`
  }

  // datatables options
  dt_options() {
    const options = new Map()
    options.set("pagingType", "full_numbers")
    options.set("dom", "<'row'<'col'l><'col'B><'col'f>>" +
                       "<'row'<'col-sm-12'tr>>" +
                       "<'row'<'col'i><'col'p>>")
    options.set("stateSave", false)
    options.set("lengthMenu", [ [10, 25, 100, 250, 1000], [10, 25, 100, 250, 1000] ])
    options.set("buttons", [ { "extend": 'copy',
	                       "exportOptions": {
	                         "columns": ':visible',
	                         "search": ':applied' } },
                             { "extend": 'excelHtml5',
	                       "exportOptions": { "search": ':applied' } },
                             { "extend": 'pdf',
	                       "orientation": 'landscape',
	                       "pageSize": 'A4',
	                       "exportOptions": { "columns": ':visible',
	                                          "search": ':applied' } },
                             { "extend": 'print'},
                             { "extend": 'colvis',
	                       "columns": ':gt(0)' } ])
    options.set("columnDefs", [ { "targets": "nosort", "orderable": false },
                                { "targets": "notvisible", "visible": false } ])
    // return json object for datatables
    return Object.fromEntries(options)
  }
} // Controller
