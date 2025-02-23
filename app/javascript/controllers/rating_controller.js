import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "icon"]
  static values = { score: Number }

  connect() {
    this.updateIcons(0)
  }

  select(event) {
    const score = parseInt(event.currentTarget.dataset.ratingScoreValue)
    // Find and check the corresponding radio button
    const radio = this.inputTargets[score - 1]
    radio.checked = true
    this.updateIcons(score)
  }

  updateIcons(selectedScore) {
    this.iconTargets.forEach((icon, index) => {
      if (index < selectedScore) {
        icon.classList.remove("text-gray-300")
        icon.classList.add("text-primary")
      } else {
        icon.classList.remove("text-primary")
        icon.classList.add("text-gray-300")
      }
    })
  }
} 