# frozen_string_literal: true
#
class Admin::ConversationsController < ApplicationController
  before_action :require_staff!
  before_action :set_conversation, only: %i[ show update assign close ]

  def index
    @conversations =
      if current_user.admin?
       Conversation.includes(:user, :staff).order(created_at: :desc)
      else
       current_user.assigned_conversations.includes(:user).order(created_at: :desc)
      end
  end

  def show
    @messages = @conversation.messages
                             .includes(:sender)
                             .order(created_at: :asc)
    @message = Message.new
  end

  def assign
    staff = User.find(params[:staff_id])

    if @conversation.update(staff: staff, status: :open)
      redirect_to admin_conversation_path(@conversation), notice: "Conversation assigned successfully to #{staff.display_name}."
    else
      redirect_to admin_conversation_path(@conversation), alert: "Failed to assign conversation."
    end
  end

  def close
    @conversation.update(status: :closed, staff: nil, department: :unassigned)
    redirect_to admin_conversations_path, notice: "Conversation closed successfully."
  end

  private

  def set_conversation

    @conversation = Conversation.find(params[:id])
  end
end
