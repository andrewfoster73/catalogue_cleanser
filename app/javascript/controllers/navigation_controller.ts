import {ActionEvent, Controller} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["element", "expander"];
  static values = {
    navigationPath: String
  }

  declare readonly navigationPathValue: string;
  declare readonly expanderTarget: HTMLElement;
  declare readonly elementTarget: HTMLAnchorElement;
  declare readonly elementTargets: HTMLAnchorElement[];

  elementTargetConnected(target: HTMLAnchorElement) {
    // If the path for the target is the same as the current then expand the menu and mark it as active
    if (this.navigationPathValue === target.href) {
      this.toggleExpander();
      this.toggleElementVisibility();
      this.setActive(target);
    }
  }

  toggle(event: ActionEvent) {
    event.preventDefault();
    this.toggleExpander();
    this.toggleElementVisibility();
  }

  toggleExpander() {
    // Rotate the triangle icon representing whether the menu is open or not
    if (this.expanderTarget.classList.contains("text-gray-300")) {
      this.expanderTarget.classList.remove("text-gray-300");
      this.expanderTarget.classList.add("text-gray-400", "rotate-90");
    } else {
      this.expanderTarget.classList.remove("text-gray-400", "rotate-90");
      this.expanderTarget.classList.add("text-gray-300");
    }
  }

  toggleElementVisibility() {
    // Show or hide the elements underneath the expander
    this.elementTargets.forEach((element) => {
      if (element.classList.contains("hidden")) {
        element.classList.remove("hidden");
        element.classList.add("block");
      } else {
        element.classList.add("hidden");
        element.classList.remove("block");
      }
    });
  }

  setActive(target: HTMLAnchorElement) {
    target.classList.remove("text-gray-300", "hover:bg-gray-700", "hover:text-white")
    target.classList.add("bg-gray-900", "text-white")
  }
}