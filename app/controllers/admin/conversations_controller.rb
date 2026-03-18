# frozen_string_literal: true

class Admin::ConversationsController < ApplicationController
  before_action :require_staff_role
  before_action :set_conversation, only: %i[ show update assign close reopen ]
  before_action :require_admin_for_reopen, only: %i[ reopen ]

  def index
    @conversations =
      if current_user.admin?
        Conversation.includes(:user, :staff).order(created_at: :desc)
      else
        current_user.assigned_conversations.includes(:user, :staff).order(created_at: :desc).where(staff: current_user)
      end
  end

  def show
    @messages = @conversation.messages
                             .includes(:sender)
                             .order(created_at: :asc)
    @message = Message.new unless @conversation.closed?
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
    if @conversation.update(status: :closed, closed_at: Time.current)
      redirect_to admin_conversations_path, notice: "Conversation closed successfully."
    else
      redirect_to admin_conversation_path(@conversation), alert: "Failed to close conversation."
    end
  end

  def reopen
    if @conversation.reopen!
      redirect_to admin_conversation_path(@conversation), notice: "Conversation reopened successfully."
    else
      redirect_to admin_conversation_path(@conversation), alert: "Failed to reopen conversation."
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  def require_staff_role
    redirect_to root_path, alert: 'You do not have access to the admin panel.' unless current_user.staff?
  end

  def require_admin_for_reopen
    redirect_to admin_conversation_path(@conversation), alert: 'Only admins can reopen conversations.' unless current_user.admin?
  end
end
