import {ActionEvent, Controller} from "@hotwired/stimulus"
import cash, {Cash} from "cash-dom";

export default class extends Controller {
    static values = {
        attribute: String
    }

    declare readonly attributeValue: string;

    toggle(event: ActionEvent) {
        event.preventDefault()
        const optionsButton: Cash = cash(`#${this.attributeValue}_list--toggle_button`)
        const containerEl: HTMLElement = cash(`#${this.attributeValue}_list--options`)[0] as HTMLElement
        containerEl.toggleAttribute('hidden')
        optionsButton.toggleClass('-rotate-180 rotate-0')
    }

    selectOption(event: ActionEvent) {
        const targetEl: HTMLElement = event.target as HTMLElement

        if (targetEl) {
            targetEl.dispatchEvent(new Event('select'))
        }
    }
}