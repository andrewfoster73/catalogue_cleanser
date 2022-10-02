import {ActionEvent, Controller} from "@hotwired/stimulus"
import cash from "cash-dom"

export default class extends Controller {
    static values = {
        inputId: String,
        hiddenInputId: String,
        itemListId: String
    }
    static targets = ["checkmark"]

    declare readonly inputIdValue: string;
    declare readonly hiddenInputIdValue: string;
    declare readonly itemListIdValue: string;
    declare readonly checkmarkTarget: HTMLElement;
    declare readonly checkmarkTargets: HTMLElement[];

    toggle(event: ActionEvent) {
        event.preventDefault()
        const dropdownEl: HTMLElement = cash(`#${this.itemListIdValue}`)[0] as HTMLElement
        dropdownEl.toggleAttribute('hidden')
    }

    highlight(event: ActionEvent) {
        const targetEl: HTMLElement = event.target as HTMLElement
        const listItemEl = cash(`#${targetEl.id}`)
        const checkmarkEl = cash(`#${event.params.checkmarkId}`)
        listItemEl.toggleClass('text-gray-900 text-white bg-gray-900 bg-sky-600 dropdown-component__option--highlighted')
        checkmarkEl.toggleClass('text-white text-sky-600')
    }

    handleKeydown(event: ActionEvent & KeyboardEvent) {
        event.preventDefault()
        const dropdownEl = cash(`#${this.itemListIdValue}`)
        const highlightedEl = dropdownEl.children('li.dropdown-component__option--highlighted')
        let nextEl: HTMLElement | undefined
        let prevEl: HTMLElement | undefined

        if (highlightedEl.length > 0) {
            // There is an element highlighted, so now work out what to do with it
            prevEl = highlightedEl[0]

            if (event.key === 'ArrowDown') {
                // Find the next element to highlight
                nextEl = highlightedEl.next('li.dropdown-component__option')[0] as HTMLElement
            } else if (event.key === 'ArrowUp') {
                // Find the previous element to highlight
                nextEl = highlightedEl.prev('li.dropdown-component__option')[0] as HTMLElement
            } else if (event.key === 'Enter' && prevEl) {
                // Select the element the user has highlighted
                prevEl.dispatchEvent(new Event('click'))
                return
            } else {
                // Future handling of autocomplete or jumping to entry starting with given key
            }
        } else {
            // Use the first element by default
            nextEl = dropdownEl.find('li.dropdown-component__option')[0] as HTMLElement
        }
        if (nextEl) {
            // mouseenter to trigger highlighting
            nextEl.dispatchEvent(new Event('mouseenter'))
        }
        if (nextEl && prevEl) {
            // mouseleave to trigger highlight removal (but only if the user has not reached the last option)
            prevEl.dispatchEvent(new Event('mouseleave'))
        }
    }

    select(event: ActionEvent) {
        const checkmarkEl: HTMLElement | null = document.querySelector(`#${event.params.checkmarkId}`)
        const inputEl: HTMLInputElement | null = document.querySelector(`#${this.inputIdValue}`)
        const hiddenInputEl: HTMLInputElement | null = document.querySelector(`#${this.hiddenInputIdValue}`)
        const value: string = event.params.itemValue
        const text: string = event.params.itemText

        if (inputEl && hiddenInputEl) {
            inputEl.value = text
            hiddenInputEl.value = value
            // Deselect any currently selected
            this.checkmarkTargets.forEach(function (checkmark) {
                checkmark.classList.add('hidden')
            })
            // Select this element
            if (checkmarkEl) {
                checkmarkEl.classList.remove('hidden')
            }
            // Hide the dropdown
            this.toggle(event)
        }
    }
}