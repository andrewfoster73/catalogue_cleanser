import {post, destroy} from "@rails/request.js";
import {Controller} from "@hotwired/stimulus"
import cash from "cash-dom"

export default class extends Controller {
  navigate(event) {
    window.location = event.params.url
  }

  new(event) {
    const modalName = event.params.modalName
    const modal = cash(`#${modalName}_modal`)

    modal.show()
  }

  async create(event) {
    const resourceUrl = event.params.url
    const resourceName = event.params.name
    const formId = event.params.formId
    const modalName = event.params.modalName
    const modal = cash(`#${modalName}_modal`)
    const form = cash(`#${formId}`)[0]
    const formData = new FormData(document.getElementById(formId));

    if (form.checkValidity()) {
      const response = await post(resourceUrl, {body: formData, responseKind: 'json'})
      if (response.ok) {
        modal.hide()
      } else {
        const me = this
        response.json.then(function (errors) {
          me.dispatch('error', {detail: {resourceName: resourceName, errors: errors}})
        })
      }
    }
  }

  update(event) {
    const formId = event.params.formId
    const form = cash(`#${formId}`)[0]

    if (form.checkValidity()) {
      form.requestSubmit()
    }
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
    destroy(`${resourceUrl}/${resourceId}`, {responseKind: 'turbo-stream'})
  }

  async delete(event) {
    const resourceId = event.params.id
    const resourceUrl = event.params.url
    const modalName = event.params.modalName
    const modal = cash(`#${modalName}_modal`)

    modal.hide()
    const response = await destroy(`${resourceUrl}/${resourceId}`, {responseKind: 'json'})
    if (response.ok) {
      window.location = resourceUrl
    }
  }
}