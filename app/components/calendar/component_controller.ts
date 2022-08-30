import {ActionEvent, Controller} from "@hotwired/stimulus"
import cash from "cash-dom";

export default class extends Controller {
    static values = {
        inputId: String
    }

    declare readonly inputIdValue: string;

    toggle(event: ActionEvent) {
        event.preventDefault()
        const calendar: HTMLElement = cash(`#${event.params.toggleCalendarId}`)[0] as HTMLElement
        calendar.toggleAttribute('hidden')
    }

    selectDate(event: ActionEvent) {
        const targetEl: HTMLElement = event.target as HTMLElement
        const buttonEl: HTMLButtonElement = targetEl.closest('button') as HTMLButtonElement
        const timeEl: HTMLTimeElement = buttonEl.querySelector('time') as HTMLTimeElement
        const date: string | null = timeEl.getAttribute('datetime')
        const inputEl: HTMLInputElement | null = document.querySelector(`#${this.inputIdValue}`)

        if (inputEl && date) {
            inputEl.value = date
            inputEl.dispatchEvent(new Event('select'))
        }
    }
}