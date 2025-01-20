import { Application } from "@hotwired/stimulus"
import { Autocomplete } from "stimulus-autocomplete"
import "swiper/element/bundle";

const application = Application.start()
application.register('autocomplete', Autocomplete)

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
