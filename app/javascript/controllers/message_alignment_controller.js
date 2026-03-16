import { Controller } from "@hotwired/stimulus"

// Conecta automáticamente a data-controller="message-alignment"
export default class extends Controller {
  static values = {
    bgColor: String,
    textColor: String
  }

  connect() {
    this.alignMessage()
  }

  alignMessage() {
    const senderId = this.element.dataset.senderId
    const messagesContainer = document.getElementById('messages')
    const currentUserId = messagesContainer?.dataset.currentUserId

    // Comparación robusta convirtiendo ambos a string
    const isMine = senderId && currentUserId && senderId.toString() === currentUserId.toString()

    const messageContent = this.element.querySelector('.message-content')
    const badge = this.element.querySelector('.badge')

    if (isMine) {
      // Es mi mensaje - alineado a la derecha con fondo gris
      this.element.classList.add('justify-content-end')
      this.element.classList.remove('justify-content-start')
      
      if (messageContent) {
        messageContent.style.backgroundColor = '#e9ecef'  // Gris claro
        messageContent.style.color = '#212529'  // Texto oscuro
      }
      
      // Ocultar el badge de rol en mensajes propios
      if (badge) {
        badge.style.display = 'none'
      }
    } else {
      // Mensaje de otro - alineado a la izquierda con colores según rol
      this.element.classList.add('justify-content-start')
      this.element.classList.remove('justify-content-end')
      
      // Mantener los colores originales del rol
      if (messageContent && this.hasBgColorValue && this.hasTextColorValue) {
        messageContent.style.backgroundColor = this.bgColorValue
        messageContent.style.color = this.textColorValue
      }
      
      // Mostrar el badge
      if (badge) {
        badge.style.display = 'inline'
      }
    }
  }
}


