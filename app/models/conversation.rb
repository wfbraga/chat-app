class Conversation < ApplicationRecord
  belongs_to :user
  belongs_to :staff, class_name: 'User', optional: true

  has_many :messages, dependent: :destroy
  has_one :latest_message, -> { order(created_at: :desc) }, class_name: 'Message'

  enum status: { awaiting_assignment: 0, open: 1, closed: 2 }
  enum department: { unassigned: 0, support: 1, sales: 2 }

  validates :user, presence: true
  validate :staff_must_be_staff_member

  scope :unrouted, -> { where(staff: nil) }
  scope :active,   -> { where(status: [:awaiting_assignment, :open]) }
  scope :visible_to, ->(user) { where('user_id = :id OR staff_id = :id', id: user.id)}

  private

  def staff_must_be_staff_member
    errors.add(:staff, 'must be a staff member') unless staff.nil? || staff.staff?
  end

  def reopen!
    update(status: :open, closed_at: nil)
  end
end
