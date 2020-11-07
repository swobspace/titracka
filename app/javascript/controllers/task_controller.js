import ApplicationController from './application_controller'

export default class extends ApplicationController {

  connect () {
    super.connect()
    // add your code here, if applicable
  }

  afterShow(element) {
    let modal_id = element.dataset["modalId"]
    let modal_element = document.getElementById(modal_id)
    $(modal_element).modal()
  }

}
