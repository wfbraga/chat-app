class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, class_name: 'User'

  has_one_attached :attachment

  validates :body, presence: true, unless: :attachment_attached?
  validates :sender, presence: true
  validate :sender_is_participant
  validate :conversation_must_be_open

  scope :unread, -> { where(read_at: nil) }

  after_create_commit { broadcast_message }

  def read?
    read_at.present?
  end

  def mark_as_read!
    touch(:read_at) if unread?
  end

  def unread?
    read_at.nil?
  end

  def attachment_attached?
    attachment.attached?
  end

  def sent_by?(user_id)
    sender_id == user_id
  end

  def sender_is_participant
    return unless conversation && sender

    allowed = [conversation.user_id, conversation.staff_id]
    unless allowed.include?(sender.id) || sender.admin?
      errors.add(:sender, 'must be a participant in the conversation or an admin')
    end
  end

  def conversation_must_be_open
    if conversation&.closed?
      errors.add(:conversation, 'cannot add messages to closed conversation')
    end
  end

  private

  def broadcast_message
    # Broadcast para el usuario normal (usa el partial de usuario)
    broadcast_append_to(
      "user_#{conversation.user_id}_conversation_#{conversation.id}_messages",
      target: 'messages',
      partial: 'messages/message',
      locals: { message: self, viewing_user_id: conversation.user_id }
    )
    
    # Broadcast para staff/admin (usa el partial de admin)
    broadcast_append_to(
      "staff_conversation_#{conversation.id}_messages",
      target: 'messages',
      partial: 'admin/messages/message',
      locals: { message: self }
    )
  end
end
