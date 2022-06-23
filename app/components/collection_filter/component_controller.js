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
    const toggle = cash(`#${event.params.toggleId}`)
    const button = toggle.parent('button')
    const trueField = cash(`#q_${event.params.true}`)
    const notTrueField = cash(`#q_${event.params.notTrue}`)
    const form = cash(`#${this.searchFormIdValue}`)[0]

    if (toggle.hasClass('translate-x-0')) {
      // Enabled
      this.toggleClasses(toggle, button)
      trueField[0].value = '1'
      notTrueField[0].value = '0'
    } else {
      // Not Enabled
      this.toggleClasses(toggle, button)
      trueField[0].value = '0'
      notTrueField[0].value = '1'
    }

    form.requestSubmit()
  }

  toggleClasses(toggle, button) {
    toggle.toggleClass('translate-x-0 translate-x-5')
    button.toggleClass('bg-gray-200 bg-indigo-600')
  }
}