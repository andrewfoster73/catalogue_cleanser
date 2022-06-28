import { destroy } from "@rails/request.js";
import { Controller } from "@hotwired/stimulus"
import cash from "cash-dom"

export default class extends Controller {
  navigate(event) {
    window.location = event.params.url
  }

  update(event) {
    const formId = event.params.formId
    const form = cash(`#${formId}`)[0]

    form.requestSubmit()
  }

  confirmDelete(event) {
    const resourceId = event.params.id
    const modalName = event.params.modalName
    const modal = cash(`#${modalName}_modal`)
    const confirmDeleteButton = cash(`#confirm_delete`)

    confirmDeleteButton.data('resource-id-param', resourceId)
    modal.show()
  }

  inlineDelete(event) {
    const resourceId = event.params.id
    const resourceUrl = event.params.url
    const modalName = event.params.modalName
    const modal = cash(`#${modalName}_modal`)

    modal.hide()
    destroy(`${resourceUrl}/${resourceId}`, { responseKind: 'turbo-stream' })
  }

  async delete(event) {
    const resourceId = event.params.id
    const resourceUrl = event.params.url
    const modalName = event.params.modalName
    const modal = cash(`#${modalName}_modal`)

    modal.hide()
    const res = await destroy(`${resourceUrl}/${resourceId}`, { responseKind: 'json' })
    if (res.response.ok) {
      window.location = resourceUrl
    }
  }
}