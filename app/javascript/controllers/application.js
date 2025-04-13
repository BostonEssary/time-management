import { Application } from "@hotwired/stimulus"
import { Autocomplete } from "stimulus-autocomplete"
import  Dropdown  from "@stimulus-components/dropdown"
import "swiper/element/bundle";

const application = Application.start()
application.register('autocomplete', Autocomplete)
application.register('dropdown', Dropdown)
application.debug = true
window.Stimulus   = application

export { application }
