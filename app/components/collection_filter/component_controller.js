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

    this.toggleFields(trueField, notTrueField)
    this.toggleClasses(toggle, button)

    form.requestSubmit()
  }

  toggleClasses(toggle, button) {
    toggle.toggleClass('translate-x-0 translate-x-5')
    button.toggleClass('bg-gray-200 bg-sky-600')
  }

  toggleFields(trueField, notTrueField) {
    trueField[0].value = 1 - parseInt(trueField[0].value)
    notTrueField[0].value = 1 - parseInt(notTrueField[0].value)
  }
}