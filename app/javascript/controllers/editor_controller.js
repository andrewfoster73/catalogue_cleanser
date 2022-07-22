import {get, patch} from "@rails/request.js";
import {Controller} from "@hotwired/stimulus"
import cash from "cash-dom"
import { enter, leave } from "el-transition"

export default class extends Controller {
  animate(event) {
    const action = event.target.attributes.action.value
    const source = event.srcElement.attributes.target.value

    if (action === 'remove') {
      const target = cash(`#${event.target.attributes.target.value}`)[0]
      event.preventDefault()
      Promise.all([
        enter(target)
      ]).then(() => {
        event.target.performAction()
      })
    }

    if (action === 'prepend' && source === 'collection_rows') {
      event.preventDefault()
      event.target.performAction()
      const target = cash("#collection_rows tr")[0]
      enter(target)
    }
  }

  editNextAttribute(id) {
    const currentRow = cash(`#${id}`).closest('.collection-rows__row')
    const nextRow = currentRow.next('.collection-rows__row')
    nextRow.find('.editable-element').trigger('click')
  }

  toggle(event) {
    event.preventDefault();
    const resourceUrl = event.params.url
    const attribute = event.params.attribute
    const input = cash(`#${event.params.fieldId}`)
    const body = {}

    body[attribute] = input.val()
    patch(resourceUrl, {body: body, responseKind: 'json'})
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
      const resourceName = event.params.resourceName

      get(`${resourceUrl}?${resourceName}[${attribute}]=`, {responseKind: 'turbo-stream'})
    }
  }
}