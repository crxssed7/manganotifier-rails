import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="custom-colour"
export default class extends Controller {
  static targets = ['colour']

  declare readonly colourTargets: HTMLElement[]

  connect (): void {
    this.updateColours()
  }

  updateColours (): void {
    this.colourTargets.forEach((element) => {
      const colour = element.getAttribute('data-colour')
      if (colour === null) return

      element.addEventListener(
        'mouseenter',
        (event: Event) => {
          const currentTarget = event.currentTarget as HTMLElement | null
          if (currentTarget === null) return
          currentTarget.style.backgroundColor = colour
        },
        false
      )

      element.addEventListener(
        'mouseleave',
        (event: Event) => {
          const currentTarget = event.currentTarget as HTMLElement | null
          if (currentTarget === null) return
          currentTarget.style.backgroundColor = 'whitesmoke'
        },
        false
      )
    })
  }
}
