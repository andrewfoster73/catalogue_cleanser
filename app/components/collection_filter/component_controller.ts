import {ActionEvent, Controller} from "@hotwired/stimulus"
import cash, {Cash} from "cash-dom"

export default class extends Controller {
  static values = {
    searchFormId: String
  }

  declare readonly searchFormIdValue: string;

  filter(event: ActionEvent) {
    if (event.params.key === 'Enter') {
      event.preventDefault()
      const form: HTMLFormElement = cash(`#${this.searchFormIdValue}`)[0] as HTMLFormElement

      form.requestSubmit()
    }
  }

  toggle(event: ActionEvent) {
    const toggle: Cash = cash(`#${event.params.toggleId}`)
    const button = toggle.parent('button')
    const trueField: Cash = cash(`#q_${event.params.true}`)
    const notTrueField: Cash = cash(`#q_${event.params.notTrue}`)
    const form: HTMLFormElement = cash(`#${this.searchFormIdValue}`)[0] as HTMLFormElement

    this.toggleFields(trueField, notTrueField)
    this.toggleClasses(toggle, button)

    form.requestSubmit()
  }

  toggleClasses(toggle: Cash, button: Cash) {
    toggle.toggleClass('translate-x-0 translate-x-5')
    button.toggleClass('bg-gray-200 bg-sky-600')
  }

  toggleFields(trueField: Cash, notTrueField: Cash) {
    const trueInput: HTMLInputElement = trueField[0] as HTMLInputElement
    const notTrueInput: HTMLInputElement = notTrueField[0] as HTMLInputElement
    trueInput.value = `${1 - parseInt(trueInput.value)}`
    notTrueInput.value = `${1 - parseInt(notTrueInput.value)}`
  }
}