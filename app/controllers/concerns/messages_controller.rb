# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :require_user_role!
  before_action :set_conversation

  def create
    @message = @conversation.messages.new(
      sender: current_user,
      body: params[:message][:body]
    )

    if @message.save
      redirect_to @conversation
    else
      render 'conversations/show', status: :unprocessable_entity
    end
  end

  private

  def set_conversation
    @conversation = current_user.conversation
    redirect_to conversations_path unless @conversation
  end
end

