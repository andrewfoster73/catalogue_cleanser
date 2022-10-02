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

    handleKeydown(event: ActionEvent & KeyboardEvent) {
        event.preventDefault()
        const dropdownEl = cash(`#${this.itemListIdValue}`)
        const highlightedItem = dropdownEl.children('li.dropdown-component__option--highlighted')
        const currentItem = highlightedItem[0]
        let nextItem: HTMLElement | undefined

        if (event.key === 'Enter') {
            this.handleEnter(currentItem)
        }
        if (event.key === 'ArrowDown') {
            nextItem = this.getNextItem(highlightedItem, dropdownEl)
        }
        if (event.key === 'ArrowUp') {
            nextItem = this.getPreviousItem(highlightedItem, dropdownEl)
        }
        // In future handle other keys

        this.triggerHighlight(nextItem, currentItem)
    }
    
    getNextItem(highlightedItem: Cash, dropdownEl: Cash): HTMLElement {
        if (highlightedItem.length > 0) {
            return highlightedItem.next('li.dropdown-component__option')[0] as HTMLElement
        } else {
            return dropdownEl.find('li.dropdown-component__option')[0] as HTMLElement
        }
    }
    
    getPreviousItem(highlightedItem: Cash, dropdownEl: Cash) {
        if (highlightedItem.length > 0) {
            return highlightedItem.prev('li.dropdown-component__option')[0] as HTMLElement
        } else {
            return dropdownEl.find('li.dropdown-component__option')[0] as HTMLElement
        }
    }
    
    handleEnter(currentItem: HTMLElement | undefined) {
        // Select the element the user has highlighted (if there is one)
        if (currentItem) {
            currentItem.dispatchEvent(new Event('click'))    
        }
    }
    
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