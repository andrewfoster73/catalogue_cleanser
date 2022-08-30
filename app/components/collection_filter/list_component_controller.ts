import {ActionEvent, Controller} from "@hotwired/stimulus"
import cash from "cash-dom";

export default class extends Controller {
    static values = {
        attribute: String
    }

    declare readonly attributeValue: string;

    toggle(event: ActionEvent) {
        event.preventDefault()
        const optionsContainer: HTMLElement = cash(`#${this.attributeValue}_list--options`)[0] as HTMLElement
        optionsContainer.toggleAttribute('hidden')
    }

    selectOption(event: ActionEvent) {
        const targetEl: HTMLElement = event.target as HTMLElement

        if (targetEl) {
            targetEl.dispatchEvent(new Event('select'))
        }
    }
}