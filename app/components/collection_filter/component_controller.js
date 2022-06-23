import { Controller } from "@hotwired/stimulus"
import cash from "cash-dom"

export default class extends Controller {
  static values = {
    searchFormId: String
  }

  filter(event) {
    if (event.key === 'Enter') {
      event.preventDefault()
      const form = cash(`#${this.searchFormIdValue}`)[0]

      form.requestSubmit()
    }
  }

  toggle(event) {
    console.log(event)
    const toggle = cash(`#${event.params.toggleId}`)
    const button = toggle.parent('button')
    const trueField = cash(`#q_${event.params.true}`)
    const notTrueField = cash(`#q_${event.params.notTrue}`)
    const form = cash(`#${this.searchFormIdValue}`)[0]

    console.log(toggle)
    if (toggle.hasClass('translate-x-0')) {
      // Enabled
      toggle.removeClass('translate-x-0')
      toggle.addClass('translate-x-5')
      button.removeClass('bg-gray-200')
      button.addClass('bg-indigo-600')
      trueField[0].value = '1'
      notTrueField[0].value = '0'
    } else {
      // Not Enabled
      toggle.removeClass('translate-x-5')
      toggle.addClass('translate-x-0')
      button.removeClass('bg-indigo-600')
      button.addClass('bg-gray-200')
      trueField[0].value = '0'
      notTrueField[0].value = '1'
    }

    form.requestSubmit()
  }
}