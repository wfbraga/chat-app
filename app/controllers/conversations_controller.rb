class ConversationsController < ApplicationController
  before_action :require_user_role, only: %i[ index show create ]
  before_action :set_conversation, only: %i[ show ]

  def index
    @conversations = current_user.conversations.includes(:staff, :latest_message).order(created_at: :desc)
    render :index
  end

  def show
    authorize_conversation_access!
    unless @conversation.closed?
      @messages = @conversation.messages.includes(:sender).order(created_at: :asc) if @conversation.messages.any?
    end
  end

  def create
    @conversation = current_user.conversations.build(department: params[:department] || :unassigned, status: :awaiting_assignment)
    if @conversation.save
      redirect_to @conversation, notice: 'Hola! Aguarde un momento mientras se abre una nueva conversación.'
    else
      redirect_to :index, alert: 'Failed to create conversation.'
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  def authorize_conversation_access!
    unless @conversation.user_id == current_user.id
      redirect_to conversations_path, alert: 'You do not have access to this conversation.'
    end
  end

  def require_user_role
    redirect_to admin_conversations_path if current_user.staff?
  end
end

