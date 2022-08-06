import {Controller} from "@hotwired/stimulus"
import cash from "cash-dom"

interface ErrorEvent {
  detail: {
      resourceName: string,
      errors: string[]
  }
}

export default class extends Controller {
  show({detail: {resourceName, errors}}: ErrorEvent) {
    for (const [field, messages] of Object.entries(errors)) {
      const messageTag = cash(`#${resourceName}_${field}--server_side_invalid_message`)
      messageTag.empty()
      for (const message of messages) {
        messageTag.append(`<p class="validation">${field} ${message}</p>`)
      }
    }
  }
}