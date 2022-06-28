import { Controller } from "@hotwired/stimulus"
import cash from "cash-dom"

export default class extends Controller {
  close(event) {
    console.log(event.params)
    const modal = cash(`#${event.params.name}_modal`)
    modal.hide()
  }
}