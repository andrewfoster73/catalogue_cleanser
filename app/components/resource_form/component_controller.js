import { Controller } from "@hotwired/stimulus"
import cash from "cash-dom"

export default class extends Controller {
  toggle(event) {
    // UI behaviour that toggles a boolean switch from true->false or false->true
    const toggle = cash(`#${event.params.toggleId}`)
    const button = toggle.parent('button')
    const input = cash(`#${event.params.fieldId}`)
    const toggled = input.val() === 'true'

    input.val(!toggled)
    toggle.toggleClass('translate-x-0 translate-x-5')
    button.toggleClass('bg-gray-200 bg-sky-600')
  }

  selectAll(event) {
    // UI behaviour that selects all existing text when editing
    event.target.select();
  }

  change(event) {
    // UI behaviour that removes any existing server side errors if the user makes a change
    const fieldId = event.params.fieldId
    const messageTag = cash(`#${fieldId}--server_side_invalid_message`)[0]
    messageTag.innerHTML = ''
  }
}