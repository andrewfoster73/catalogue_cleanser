import {patch} from "@rails/request.js";
import {Controller} from "@hotwired/stimulus"
import cash from "cash-dom"

export default class extends Controller {
  editNextAttribute(id) {
    const currentRow = cash(`#${id}`).closest('.collection-rows__row')
    const nextRow = currentRow.next('.collection-rows__row')
    console.log('editNext', id, currentRow, nextRow)
    nextRow.find('.editable-element').trigger('click')
  }

  toggle(event) {
    event.preventDefault();
    const resourceUrl = event.params.url
    const attribute = event.params.attribute
    const input = cash(`#${event.params.fieldId}`)
    const body = {}

    body[attribute] = input.val()
    const response = patch(resourceUrl, {body: body, responseKind: 'json'})
  }

  async save(event) {
    if (event.key === 'Enter' || event.key === 'Tab') {
      event.preventDefault();
      const resourceUrl = event.params.url
      const fieldId = event.params.fieldId
      const attribute = event.params.attribute
      const body = {}

      body[attribute] = event.currentTarget.value
      const response = await patch(resourceUrl, {body: body, responseKind: 'turbo-stream'})
      if (response.ok) {
        this.editNextAttribute(fieldId)
      } else {
        // TODO: Show error label?
      }
    }
  }

  cancel(event) {
    if (event.key === 'Escape' || event.key === 'Esc') {
      event.preventDefault();
      const resourceUrl = event.params.url
      const attribute = event.params.attribute
      const body = {}

      body[attribute] = event.currentTarget.value
      patch(resourceUrl, {body: body, responseKind: 'turbo-stream'})
    }
  }
}