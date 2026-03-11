# frozen_string_literal: true

class ConversationsController < ApplicationController
  def index
    @conversation = current_user.conversation
    if @conversation
      redirect_to @conversation
    else
      render :index
    end
  end

  def show
    @conversation = current_user.conversation
    redirect_to conversations_path unless @conversation
    @messages = @conversation.messages.order(created_at: :asc)
  end

  def create
    if current_user.conversation.present?
      redirect_to current_user.conversation, alert: 'You are already in a conversation.'
      return
    end
    @conversation = Conversation.new(user: current_user, department: params[:department] || :unassigned)
    if @conversation.save
      redirect_to @conversation
    else
      redirect_to :index, alert: 'Failed to create conversation.'
    end
  end
end

