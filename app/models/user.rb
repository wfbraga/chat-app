class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :conversation, foreign_key: :user_id, dependent: :destroy
  has_many :assigned_conversations, foreign_key: :staff_id, class_name: 'Conversation'
  has_many :sent_messages, foreign_key: :sender_id, class_name: 'Message'

  enum role: { user: 0, admin: 1, support: 2, sales: 3}

  def staff?
    admin? || support? || sales?
  end
end
