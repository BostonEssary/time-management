import Popover from "@stimulus-components/popover"

export default class extends Popover {
  connect() {
    super.connect()
    this.isVisible = false
  }

  toggle(event) {

    if (this.isVisible) {
      super.hide()
    } else {
      super.show(event)
    }
    this.isVisible = !this.isVisible
    console.log("Popover controller toggle!")
  }
} 