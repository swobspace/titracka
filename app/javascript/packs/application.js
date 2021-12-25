// 

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "bootstrap";
import '@fortawesome/fontawesome-free/js/all'
import "@fortawesome/fontawesome-free/css/all.css"
import "../stylesheets/application";

import JSZip from 'jszip'
require('pdfmake')
require('datatables.net-bs4')
require('datatables.net-buttons-bs4')
require('datatables.net-buttons/js/buttons.colVis.js')
require('datatables.net-buttons/js/buttons.html5.js')
require('datatables.net-buttons/js/buttons.print.js')
require('moment')
require('select2/dist/js/select2')
require('jstree')
require('jstree/dist/themes/default/style.min.css')
require('flatpickr/dist/flatpickr')

window.JSZip = JSZip;

import "controllers"

require("trix")
require("@rails/actiontext")
