import { Controller } from "@hotwired/stimulus"
import { useIntersection } from 'stimulus-use'

export default class extends Controller<HTMLAnchorElement> {
  options = {
    threshold: 1
  }

  declare isVisible: boolean

  connect() {
    useIntersection(this, this.options)
  }

  appear(_entry: IntersectionObserverEntry) {
    this.element.click()
  }
}