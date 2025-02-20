import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll-to"
export default class extends Controller {
  connect() {
    console.log('scroll-to connected')

    

    this.element.scrollIntoView({ behavior: 'smooth' })
  }
}
