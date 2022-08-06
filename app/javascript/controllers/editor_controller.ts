import { get, patch } from "@rails/request.js";
import { ActionEvent, Controller } from "@hotwired/stimulus"
import cash from "cash-dom"
import { enter } from "el-transition"
import { StreamElement } from "@hotwired/turbo/dist/types/elements";

interface UpdateBody {
  [key: string]: string
}

export default class extends Controller {
  animate(event: ActionEvent) {
    const stream = event.target as StreamElement
    const action = stream?.action
    const source = stream?.target

    if (action === 'remove') {
      const target = cash(`#${stream?.target}`)[0]
      event.preventDefault()
      Promise.all([
        enter(target)
      ]).then(() => {
        stream.performAction()
      })
    }

    if (action === 'prepend' && source === 'collection_rows') {
      event.preventDefault()
      stream.performAction()
      const target = cash("#collection_rows tr")[0]
      enter(target)
    }
  }

  editNextAttribute(id: string) {
    const currentRow = cash(`#${id}`).closest('.collection-rows__row')
    const nextRow = currentRow.next('.collection-rows__row')
    nextRow.find('.editable-element').trigger('click')
  }

  toggle(event: ActionEvent) {
    event.preventDefault();
    const resourceUrl = event.params.url
    const attribute = event.params.attribute
    const input = cash(`#${event.params.fieldId}`)[0] as HTMLInputElement
    const body: UpdateBody = {}

    body[attribute] = input.value
    patch(resourceUrl, { body: body, responseKind: 'json' })
  }

  async save(event: ActionEvent & KeyboardEvent) {
    const fieldId = event.params.fieldId

    if (event.key === 'Enter' || event.key === 'Tab') {
      event.preventDefault();
      const resourceUrl = event.params.url
      const attribute = event.params.attribute
      const input = event.currentTarget as HTMLInputElement
      const body: UpdateBody = {}

      body[attribute] = input.value
      const response = await patch(resourceUrl, { body: body, responseKind: 'turbo-stream' })
      if (response.ok) {
        this.editNextAttribute(fieldId)
      }
    }
  }

  cancel(event: ActionEvent & KeyboardEvent) {
    if (event.key === 'Escape' || event.key === 'Esc') {
      event.preventDefault();
      const resourceUrl = event.params.url
      const attribute = event.params.attribute
      const resourceName = event.params.resourceName

      get(`${resourceUrl}?${resourceName}[${attribute}]=`, { responseKind: 'turbo-stream' })
    }
  }
}