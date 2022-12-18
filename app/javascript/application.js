// app/javascript/application.js
import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"

import * as bootstrap from "bootstrap"
window.bootstrap = bootstrap

import "./controllers"

require("trix")
require("@rails/actiontext")

