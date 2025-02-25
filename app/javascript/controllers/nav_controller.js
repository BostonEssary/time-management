import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nav"
export default class extends Controller {
  static targets = ['mobileMenu', 'overlay']

  connect() {
    console.log('nav controller connected')
  }

  toggleMobileMenu() {
    this.overlayTarget.classList.toggle('hidden')
    document.body.classList.toggle('overflow-hidden')
  }
}
