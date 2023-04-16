// app/javascript/application.js
import "@hotwired/turbo-rails"
import * as ActiveStorage from "@rails/activestorage"

import * as bootstrap from "bootstrap"
window.bootstrap = bootstrap

import "./controllers"
import "./turbo_streams"

require("trix")
require("@rails/actiontext")

