import { Application } from "@hotwired/stimulus"
import { Autocomplete } from "stimulus-autocomplete"
import "swiper/element/bundle";

const application = Application.start()
application.register('autocomplete', Autocomplete)
application.debug = true
window.Stimulus   = application

export { application }
