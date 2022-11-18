import {patch, post, destroy} from "@rails/request.js";
import {ActionEvent, Controller} from "@hotwired/stimulus"
import cash from "cash-dom"

export default class extends Controller {
  navigate(event: ActionEvent) {
    if (event.params.url && event.params.target) {
      window.open(event.params.url, event.params.target);
    } else {
      window.location = event.params.url
    }
  }

  new(event: ActionEvent) {
    const modalName = event.params.modalName
    const modal = cash(`#${modalName}_modal`)

    modal.show()
  }

  async create(event: ActionEvent) {
    const resourceUrl = event.params.url
    const resourceName = event.params.name
    const formId = event.params.formId
    const modalName = event.params.modalName
    const modal = cash(`#${modalName}_modal`)
    const form: HTMLFormElement = cash(`#${formId}`)[0] as HTMLFormElement
    const formData: FormData = new FormData(form);

    if (form.checkValidity()) {
      const response = await post(resourceUrl, {body: formData, responseKind: 'json'})
      if (response.ok) {
        modal.hide()
      } else {
        const me = this
        response.json.then(function (errors: [any]) {
          me.dispatch('error', {detail: {resourceName: resourceName, errors: errors}})
        })
      }
    }
  }

  update(event: ActionEvent) {
    const formId = event.params.formId
    const form: HTMLFormElement = cash(`#${formId}`)[0] as HTMLFormElement

    if (form.checkValidity()) {
      form.requestSubmit()
    }
  }

  inlineUpdate(event: ActionEvent) {
    const resourceUrl = event.params.url
    const resourceAttribute = event.params.attribute
    const resourceValue = event.params.value
    let body: {[k: string]: any} = { }

    body[resourceAttribute] = resourceValue
    patch(`${resourceUrl}`, {body: body, responseKind: 'turbo-stream'})
  }

  confirmDelete(event: ActionEvent) {
    const resourceId = event.params.id
    const modalName = event.params.modalName
    const modal = cash(`#${modalName}_modal`)
    const confirmDeleteButton = cash(`#confirm_delete`)

    confirmDeleteButton.data('resource-id-param', resourceId)
    modal.show()
  }

  inlineDelete(event: ActionEvent) {
    const resourceId = event.params.id
    const resourceUrl = event.params.url
    const modalName = event.params.modalName
    const modal = cash(`#${modalName}_modal`)

    modal.hide()
    destroy(`${resourceUrl}/${resourceId}`, {responseKind: 'turbo-stream'})
  }

  async delete(event: ActionEvent) {
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