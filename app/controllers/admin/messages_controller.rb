# frozen_string_literal: true

class Admin::MessagesController < ApplicationController
  before_action :require_staff!
  before_action :set_conversation

  def create
    @message = @conversation.messages.new(
      sender: current_user,
      body: params[:body]
    )

    if @message.save
      redirect_to admin_conversation_path(@conversation)
    else
      render admin_conversations_path, status: :unprocessable_entity
    end
  end

  private
  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
