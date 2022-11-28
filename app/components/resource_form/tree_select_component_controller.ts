import {ActionEvent, Controller} from "@hotwired/stimulus"
import cash, { Cash } from "cash-dom"

export default class extends Controller {
    static values = {
        inputId: String,
        hiddenInputId: String,
        treeListId: String
    }
    static targets = ["checkmark"]

    declare readonly inputIdValue: string;
    declare readonly hiddenInputIdValue: string;
    declare readonly treeListIdValue: string;
    declare readonly checkmarkTarget: HTMLElement;
    declare readonly checkmarkTargets: HTMLElement[];

    // Toggle visibility of the tree list
    toggle(event: ActionEvent) {
        event.preventDefault()
        const treeSelectEl: HTMLElement = cash(`#${this.treeListIdValue}`)[0] as HTMLElement
        const inputEl: HTMLInputElement | null = document.querySelector(`#${this.inputIdValue}`)
        treeSelectEl.toggleAttribute('hidden')
        if (inputEl) {
            inputEl.dispatchEvent(new Event('focus'))
        }
    }

    // Toggle visibility of a root's children
    toggleRoot(event: ActionEvent) {
        event.preventDefault()
        const childrenEl: Cash = cash(`#${event.params.childrenId}`)
        const expanderEl: HTMLElement = cash(`#${event.params.expanderId}`)[0] as HTMLElement
        childrenEl.toggleClass('hidden')
        this.toggleExpander(expanderEl)
    }

    toggleExpander(expanderEl: HTMLElement) {
        // Rotate the triangle icon representing whether the expander is open or not
        if (expanderEl.classList.contains("text-gray-300")) {
            expanderEl.classList.remove("text-gray-300");
            expanderEl.classList.add("text-gray-400", "rotate-90");
        } else {
            expanderEl.classList.remove("text-gray-400", "rotate-90");
            expanderEl.classList.add("text-gray-300");
        }
    }

    // Set the value of the associated inputs to the item a user has selected
    select(event: ActionEvent) {
        const checkmarkEl: HTMLElement | null = document.querySelector(`#${event.params.checkmarkId}`)
        const inputEl: HTMLInputElement | null = document.querySelector(`#${this.inputIdValue}`)
        const hiddenInputEl: HTMLInputElement | null = document.querySelector(`#${this.hiddenInputIdValue}`)
        const value: string = event.params.childValue
        const text: string = event.params.childText

        if (inputEl && hiddenInputEl) {
            // Set the input values
            inputEl.value = text
            hiddenInputEl.value = value
            hiddenInputEl.dispatchEvent(new Event('change'))

            // Deselect any currently selected item
            this.checkmarkTargets.forEach(function (checkmark) {
                checkmark.classList.add('hidden')
            })

            // Select this item
            if (checkmarkEl) {
                checkmarkEl.classList.remove('hidden')
            }

            // Hide the tree select
            this.toggle(event)
        }
    }
}