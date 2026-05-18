// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

const THEME_STORAGE_KEY = "bito-theme"
const THEMES = ["light", "dark"]

function storedTheme() {
  try {
    const value = window.localStorage.getItem(THEME_STORAGE_KEY)
    return THEMES.includes(value) ? value : null
  } catch (_error) {
    return null
  }
}

function preferredTheme() {
  return storedTheme() || "light"
}

function syncThemeMeta(theme) {
  const color = theme === "dark" ? "#080808" : "#FAFAF8"
  const meta = document.querySelector('meta[name="theme-color"]')

  if (meta) meta.setAttribute("content", color)
}

function applyTheme(theme = preferredTheme()) {
  const next = THEMES.includes(theme) ? theme : "light"

  document.documentElement.setAttribute("data-theme", next)
  syncThemeMeta(next)

  document.querySelectorAll("[data-bito-theme-toggle]").forEach((button) => {
    button.setAttribute("aria-pressed", String(next === "dark"))
    button.setAttribute("title", next === "dark" ? "usar tema claro" : "usar tema escuro")
  })

  return next
}

window.bitoSetTheme = function bitoSetTheme(theme) {
  const next = applyTheme(theme)

  try {
    window.localStorage.setItem(THEME_STORAGE_KEY, next)
  } catch (_error) {
    // Sem localStorage disponível: mantém o tema só na página atual.
  }

  return next
}

window.bitoToggleTheme = function bitoToggleTheme() {
  const current = document.documentElement.getAttribute("data-theme") || preferredTheme()
  return window.bitoSetTheme(current === "dark" ? "light" : "dark")
}

applyTheme()
document.addEventListener("turbo:load", () => applyTheme())
document.addEventListener("turbo:render", () => applyTheme())
