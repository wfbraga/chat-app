import { Controller } from "@hotwired/stimulus"

// Conecta automáticamente a data-controller="messages-container"
export default class extends Controller {
  connect() {
    // Observar cambios en el contenedor para procesar nuevos mensajes
    this.observer = new MutationObserver(() => {
      this.scrollToBottom()
    })

    this.observer.observe(this.element, {
      childList: true,
      subtree: true
    })

    // Scroll inicial al final
    this.scrollToBottom()
  }

  disconnect() {
    if (this.observer) {
      this.observer.disconnect()
    }
  }

  scrollToBottom() {
    this.element.scrollTop = this.element.scrollHeight
  }
}

