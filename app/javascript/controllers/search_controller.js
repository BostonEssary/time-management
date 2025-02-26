import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = []
  
  connect() {
    this.timeout = null
  }

  debounce(event) {
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
    
    this.timeout = setTimeout(() => {
      this.submit(event)
    }, 300)
  }

  submit(event) {
    const form = event.target.closest('form')
    if (form) {
      form.requestSubmit()
    }
  }
} 