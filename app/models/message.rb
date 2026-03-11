class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, class_name: 'User'

  has_one_attached :attachment

  validates :body, presence: true, unless: :attachment_attached?
  validates :sender, presence: true
  validate :sender_is_participant

  scope :unread, -> { where(read_at: nil) }

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

  def sender_is_participant
    return unless conversation && sender

    allowed = [conversation.user_id, conversation.staff_id]
    unless allowed.include?(sender.id) || sender.admin?
      errors.add(:sender, 'must be a participant in the conversation or an admin')
    end
  end
end
