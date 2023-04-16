// app/javascript/controllers/index.js

import { Application } from "@hotwired/stimulus"
const application = Application.start()

application.warnings = true
application.debug = false
window.Stimulus = application

export { application }

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import CheckboxListController from "./checkbox_list_controller"
application.register("checkbox-list", CheckboxListController)

import DashboardController from "./dashboard_controller"
application.register("dashboard", DashboardController)

import DatatablesController from "./datatables_controller"
application.register("datatables", DatatablesController)

import DateselectorController from "./dateselector_controller"
application.register("dateselector", DateselectorController)

import DraggableController from "./draggable_controller"
application.register("draggable", DraggableController)

import FiltersController from "./filters_controller"
application.register("filters", FiltersController)

import TurboFilterController from "./turbo_filter_controller"
application.register("turbo-filter", TurboFilterController)

import FollowmeController from "./followme_controller"
application.register("followme", FollowmeController)

import ModalController from "./modal_controller"
application.register("modal", ModalController)

import NestedFormController from "./nested_form_controller"
application.register("nested-form", NestedFormController)

import SelectController from "./ts/select_controller"
application.register("select", SelectController)

import ToggleController from "./toggle_controller"
application.register("toggle", ToggleController)

import PolymorphicSelectController from "@swobspace/stimulus-polymorphic-select"
application.register("polymorphic-select", PolymorphicSelectController)
