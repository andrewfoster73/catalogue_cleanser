import { ActionEvent, Controller } from "@hotwired/stimulus"
import cash from "cash-dom"

export default class extends Controller {
  close(event: ActionEvent) {
    const modal = cash(`#${event.params.name}_modal`)
    modal.hide()
  }
}