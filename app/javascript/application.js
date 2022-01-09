// app/javascript/application.js
import Rails from "@rails/ujs"
import { Turbo } from "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"

import * as bootstrap from "bootstrap"
require('select2/dist/js/select2')
require("trix")
require("@rails/actiontext")

Rails.start()
ActiveStorage.start()

import "./controllers"