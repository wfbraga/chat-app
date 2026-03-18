class Conversation < ApplicationRecord
  belongs_to :user
  belongs_to :staff, class_name: 'User', optional: true

  has_many :messages, dependent: :destroy
  has_one :latest_message, -> { order(created_at: :desc) }, class_name: 'Message'

  enum status: { awaiting_assignment: 0, open: 1, closed: 2 }
  enum department: { unassigned: 0, support: 1, sales: 2 }

  validates :user, presence: true
  validate :staff_must_be_staff_member
  validate :no_messages_when_closed

  scope :unrouted, -> { where(staff: nil) }
  scope :active,   -> { where(status: [:awaiting_assignment, :open]) }
  scope :visible_to, ->(user) { where('user_id = :id OR staff_id = :id', id: user.id)}

  private

  def staff_must_be_staff_member
    errors.add(:staff, 'must be a staff member') unless staff.nil? || staff.staff?
  end

  def no_messages_when_closed
    if closed_at.present? && messages.any?
      errors.add(:base, 'cannot add messages to a closed conversation')
    end
  end

  def reopen!
    update(status: :open, closed_at: nil)
  end
end
