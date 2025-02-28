import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll-to"
export default class extends Controller {
  connect() {
    this.element.scrollIntoView({ behavior: 'smooth' }) 
  }
}
