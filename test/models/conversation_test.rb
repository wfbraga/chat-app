require "test_helper"

class ConversationTest < ActiveSupport::TestCase
  fixtures :conversations, :messages, :users

  test "should be able to close a conversation with messages" do
    conversation = conversations(:one)
    conversation.staff = users(:two) # users(:two) is admin, so it's a staff member
    assert conversation.messages.any?, "Conversation should have messages"
    
    conversation.status = :closed
    conversation.closed_at = Time.current
    
    assert conversation.valid?, "Conversation should be valid when closing it even if it has messages. Errors: #{conversation.errors.full_messages}"
    assert conversation.save
  end

  test "should not be able to add a message to a closed conversation" do
    conversation = conversations(:one)
    conversation.staff = users(:two)
    # Using update_columns to bypass validations to set a historical closed_at
    conversation.update_columns(status: Conversation.statuses[:closed], closed_at: 1.hour.ago)
    
    # Reload to ensure the object is fresh
    conversation.reload

    # Message model validation should catch this
    message = Message.new(conversation: conversation, sender: users(:one), body: "New message")
    assert_not message.valid?, "Message should not be valid for a closed conversation"
    assert_includes message.errors[:conversation], "cannot add messages to closed conversation"
  end
end
