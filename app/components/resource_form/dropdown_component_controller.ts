import {ActionEvent, Controller} from "@hotwired/stimulus"
import cash, { Cash } from "cash-dom"

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

    // Toggle visibility of the item list
    toggle(event: ActionEvent) {
        event.preventDefault()
        const dropdownEl: HTMLElement = cash(`#${this.itemListIdValue}`)[0] as HTMLElement
        dropdownEl.toggleAttribute('hidden')
    }

    // Highlight an individual item from the list
    highlight(event: ActionEvent) {
        const targetEl: HTMLElement = event.target as HTMLElement
        const listItemEl = cash(`#${targetEl.id}`)
        const checkmarkEl = cash(`#${event.params.checkmarkId}`)
        listItemEl.toggleClass('text-gray-900 text-white bg-gray-900 bg-sky-600 dropdown-component__option--highlighted')
        checkmarkEl.toggleClass('text-white text-sky-600')
    }

    // Set the value of the associated inputs to the item a user has selected
    select(event: ActionEvent) {
        const checkmarkEl: HTMLElement | null = document.querySelector(`#${event.params.checkmarkId}`)
        const inputEl: HTMLInputElement | null = document.querySelector(`#${this.inputIdValue}`)
        const hiddenInputEl: HTMLInputElement | null = document.querySelector(`#${this.hiddenInputIdValue}`)
        const value: string = event.params.itemValue
        const text: string = event.params.itemText

        if (inputEl && hiddenInputEl) {
            // Set the input values
            inputEl.value = text
            hiddenInputEl.value = value

            // Deselect any currently selected item
            this.checkmarkTargets.forEach(function (checkmark) {
                checkmark.classList.add('hidden')
            })

            // Select this item
            if (checkmarkEl) {
                checkmarkEl.classList.remove('hidden')
            }

            // Hide the dropdown
            this.toggle(event)
        }
    }

    // Handle supported keydown events
    handleKeydown(event: ActionEvent & KeyboardEvent) {
        event.preventDefault()
        const dropdownEl = cash(`#${this.itemListIdValue}`)
        const highlightedItems = dropdownEl.children('li.dropdown-component__option--highlighted')
        const currentItem = highlightedItems[0]
        let nextItem: HTMLElement | undefined

        if (event.key === 'Enter') {
            this.handleEnter(currentItem)
            return
        }
        if (event.key === 'ArrowDown') {
            nextItem = this.getNextItem(highlightedItems, dropdownEl)
        }
        if (event.key === 'ArrowUp') {
            nextItem = this.getPreviousItem(highlightedItems, dropdownEl)
        }
        // In future handle other keys

        this.triggerHighlight(nextItem, currentItem)
    }

    // Get the next item that can be highlighted
    getNextItem(highlightedItems: Cash, dropdownEl: Cash): HTMLElement {
        if (highlightedItems.length > 0) {
            return highlightedItems.next('li.dropdown-component__option')[0] as HTMLElement
        } else {
            return dropdownEl.find('li.dropdown-component__option')[0] as HTMLElement
        }
    }

    // Get the previous item that can be highlighted
    getPreviousItem(highlightedItems: Cash, dropdownEl: Cash) {
        if (highlightedItems.length > 0) {
            return highlightedItems.prev('li.dropdown-component__option')[0] as HTMLElement
        } else {
            return dropdownEl.find('li.dropdown-component__option')[0] as HTMLElement
        }
    }

    // Select the element the user has highlighted (if there is one)
    handleEnter(currentItem: HTMLElement | undefined) {
        if (currentItem) {
            currentItem.dispatchEvent(new Event('click'))    
        }
    }

    // Trigger highlighting on the next item and remove it from the current item
    triggerHighlight(nextItem: HTMLElement | undefined, currentItem: HTMLElement | undefined) {
        if (nextItem) {
            // mouseenter to trigger highlighting
            nextItem.dispatchEvent(new Event('mouseenter'))
        }
        if (nextItem && currentItem) {
            // mouseleave to trigger highlight removal (but only if the user has not reached the last option)
            currentItem.dispatchEvent(new Event('mouseleave'))
        } 
    }
}