import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="alerts"
export default class extends Controller {
  static targets = [ 'alert']
  connect() {
  }

  alertTargetConnected() {
    setTimeout(() => {
     this.alertTarget.remove() 
    }, 3000);
  }

  dismiss(event) {
    event.target
    this.alertTarget.remove()
  }
}
