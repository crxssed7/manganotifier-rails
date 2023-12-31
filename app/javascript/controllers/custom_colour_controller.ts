import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="custom-colour"
export default class extends Controller {
  static targets = ['background', 'border', 'stripe']

  declare readonly backgroundTargets: HTMLElement[]
  declare readonly borderTargets: HTMLElement[]
  declare readonly stripeTargets: HTMLElement[]

  connect (): void {
    this.update(this.borderTargets, this.setBorderColour)
    this.update(this.backgroundTargets, this.setBackgroundColour)
    this.update(this.stripeTargets, this.setStripes)
  }

  setColour (element: HTMLElement, colour: string) {
    element.style.color = colour
  }

  setBackgroundColour (element: HTMLElement, colour: string) {
    element.style.backgroundColor = colour
  }

  setBorderColour (element: HTMLElement, colour: string) {
    element.style.borderColor = colour
  }

  setStripes (element: HTMLElement, colour: string) {
    element.style.background = `repeating-linear-gradient(45deg, whitesmoke, whitesmoke 55px, ${colour} 55px, ${colour} 110px)`
  }

  update (targets: HTMLElement[], setColourCallback: (element: HTMLElement, colour: string) => void): void {
    targets.forEach((element) => {
      const colour = element.getAttribute('data-colour')
      if (colour === null) return

      setColourCallback(element, colour)
    })
  }
}
