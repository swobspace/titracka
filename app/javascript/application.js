// app/javascript/application.js
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
// import { Turbo } from "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"

import * as bootstrap from "bootstrap"
// require('jstree/dist/jstree')
require('select2/dist/js/select2')
require("trix")
require("@rails/actiontext")

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "./controllers"
