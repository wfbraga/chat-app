# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :set_conversation

  def create
    @message = @conversation.messages.new(
      sender: current_user,
      body: message_params[:body]
    )

    if @message.save
      respond_to do | format |
        format.turbo_stream # response for turbo stream request
        format.html { redirect_to @conversation} # fallback for regular request
      end
    else
      render 'conversations/show', status: :unprocessable_entity
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
    redirect_to conversations_path unless @conversation
  end

  def message_params
    params.permit(:conversation_id, :body, :authenticity_token, :commit)
  end
end