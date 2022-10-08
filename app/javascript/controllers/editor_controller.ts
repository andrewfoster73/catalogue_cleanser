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

  // Toggle inputs
  toggle(event: ActionEvent) {
    event.preventDefault();
    const resourceUrl = event.params.url
    const attribute = event.params.attribute
    const input = cash(`#${event.params.fieldId}`)[0] as HTMLInputElement
    const body: UpdateBody = {}

    body[attribute] = input.value
    patch(resourceUrl, { body: body, responseKind: 'json' })
  }

  // Dropdown inputs
  select(event: ActionEvent) {
    event.preventDefault();
    const resourceUrl = event.params.url
    const attribute = event.params.attribute
    const input = cash(`#${event.params.fieldId}`)[0] as HTMLInputElement
    const body: UpdateBody = {}

    body[attribute] = input.value
    patch(resourceUrl, { body: body, responseKind: 'turbo-stream' })
  }

  // Text & Number inputs
  save(event: ActionEvent & KeyboardEvent) {
    if (event.key === 'Enter' || event.key === 'Tab') {
      event.preventDefault();
      const resourceUrl = event.params.url
      const attribute = event.params.attribute
      const input = event.currentTarget as HTMLInputElement
      const body: UpdateBody = {}

      body[attribute] = input.value
      patch(resourceUrl, { body: body, responseKind: 'turbo-stream' })
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