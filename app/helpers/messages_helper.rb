module MessagesHelper
  # Retorna los estilos de la burbuja de mensaje según el rol del remitente
  # @param message [Message] El mensaje a estilizar
  # @param viewing_user_id [Integer, nil] El ID del usuario que está viendo (solo para vista de usuario)
  # @return [Hash] Hash con :bg_color, :text_color, :alignment, :is_mine
  def message_bubble_styles(message, viewing_user_id: nil)
    is_mine = viewing_user_id.present? && message.sent_by?(viewing_user_id)
    
    if is_mine
      {
        bg_color: '#e9ecef',      # Gris claro (secondary)
        text_color: '#212529',    # Negro
        alignment: 'justify-content-end',
        is_mine: true
      }
    else
      {
        bg_color: role_background_color(message.sender.role),
        text_color: role_text_color(message.sender.role),
        alignment: 'justify-content-start',
        is_mine: false
      }
    end
  end

  # Retorna el color de fondo según el rol
  # @param role [String] El rol del usuario ('user', 'admin', 'support', 'sales')
  # @return [String] Código hexadecimal del color de fondo
  def role_background_color(role)
    case role.to_s
    when 'sales'
      '#d1e7dd'  # Verde claro (success)
    when 'support'
      '#cff4fc'  # Azul claro (info)
    when 'admin'
      '#cfe2ff'  # Azul (primary)
    when 'user'
      '#fff3cd'  # Amarillo (warning)
    else
      '#f0f0f0'  # Gris
    end
  end

  # Retorna el color de texto según el rol
  # @param role [String] El rol del usuario ('user', 'admin', 'support', 'sales')
  # @return [String] Código hexadecimal del color de texto
  def role_text_color(role)
    case role.to_s
    when 'sales'
      '#0f5132'  # Verde oscuro
    when 'support'
      '#055160'  # Azul oscuro
    when 'admin'
      '#084298'  # Azul oscuro
    when 'user'
      '#664d03'  # Amarillo oscuro
    else
      '#212529'  # Negro
    end
  end

  # Retorna las clases CSS para el badge de rol
  # @param text_color [String] Color del texto/fondo del badge
  # @return [String] Clases CSS del badge
  def role_badge_classes
    'badge badge-sm'
  end

  # Retorna el estilo inline para el badge de rol
  # @param text_color [String] Color de fondo del badge
  # @return [String] Estilo CSS inline
  def role_badge_style(text_color)
    "font-size: 0.65rem; background-color: #{text_color};"
  end
end

