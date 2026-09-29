import { Controller } from "@hotwired/stimulus"

// Seletor de fonte do corpo, visível só para admin logado.
// Troca --body-font no <html> e lembra a escolha no localStorage.
const STORAGE_KEY = "bito-font-preview"
const FALLBACK = "system-ui, -apple-system, sans-serif"

export default class extends Controller {
  static targets = ["option"]

  connect() {
    // carrega todas para que cada botão já apareça na própria fonte
    this.optionTargets.forEach((el) => this.loadFont(el))

    let saved = null
    try { saved = localStorage.getItem(STORAGE_KEY) } catch (_) {}
    this.apply(saved || this.optionTargets[0].dataset.family)
  }

  pick(event) {
    const family = event.currentTarget.dataset.family
    try { localStorage.setItem(STORAGE_KEY, family) } catch (_) {}
    this.apply(family)
  }

  apply(family) {
    const option = this.optionTargets.find((el) => el.dataset.family === family)
    if (!option) return

    document.documentElement.style.setProperty("--body-font", `'${family}', ${FALLBACK}`)
    this.optionTargets.forEach((el) => el.setAttribute("aria-pressed", el === option))
  }

  loadFont(option) {
    const href = option.dataset.href
    if (!href || document.querySelector(`link[href="${href}"]`)) return

    const link = document.createElement("link")
    link.rel = "stylesheet"
    link.href = href
    document.head.appendChild(link)
  }
}
