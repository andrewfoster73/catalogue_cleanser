import { Controller } from "@hotwired/stimulus"
import { enter, leave } from "el-transition"

export default class extends Controller {
  static targets = ["container", "notification"]

  declare readonly containerTarget: HTMLElement;
  declare readonly notificationTarget: HTMLElement;

  connect() {
    this.containerTarget.classList.remove("hidden")
    enter(this.notificationTarget)
  }

  close() {
    Promise.all([
      leave(this.notificationTarget)
    ]).then(() => {
      this.containerTarget.classList.add("hidden")
    })
  }
}