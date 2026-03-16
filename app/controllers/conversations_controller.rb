# frozen_string_literal: true

class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[ show ]
  def index
    if current_user.user?
      @conversation = current_user.conversation
      render :show and return if @conversation.present?
    elsif current_user.staff?
      @conversations = current_user.assigned_conversations.includes(:user, :staff).order(created_at: :desc).where(staff: current_user)
    end
    render :index
  end

  def show
    if !@conversation.closed?
      @messages = @conversation.messages.includes(:sender).order(created_at: :asc) if @conversation.messages.any?
    else
      render :index, alert: 'No tienes conversaciones abiertas.'
    end
  end

  def create
    @conversation = current_user.conversation
    if @conversation
      @conversation.update(department: params[:department] || :unassigned, status: :awaiting_assignment)
      debugger
      redirect_to @conversation, notice: 'Que bien que volviste!!! Aguarde un momento mientras se abre una nueva conversación.'
      return
    end
    @conversation = Conversation.new(user: current_user, department: params[:department] || :unassigned)
    if @conversation.save
      redirect_to @conversation,notice: 'Hola! Aguarde un momento mientras se abre una nueva conversación.'
    else
      redirect_to :index, alert: 'Failed to create conversation.'
    end
  end

  private

  def set_conversation
    if current_user.admin?
      @conversation = Conversation.find(params[:id])
    else
      @conversation = Conversation.visible_to(current_user).find(params[:id])
    end
  end
end

