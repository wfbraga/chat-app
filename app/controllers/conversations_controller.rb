# frozen_string_literal: true

class ConversationsController < ApplicationController
  def index
    @conversation = current_user.conversation if current_user.user?
    if @conversation
      redirect_to @conversation
    elsif current_user.staff?
      @conversations = Conversation.includes(:user, :staff).order(created_at: :desc).where(staff: current_user)
    else
      render :index
    end
  end

  def show
    @conversation = current_user.conversation

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
end

