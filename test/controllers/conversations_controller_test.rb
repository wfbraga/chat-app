require "test_helper"

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @staff = users(:two) # admin role
  end

  test "should get index if logged in as user" do
    sign_in @user
    get conversations_url
    assert_response :success
  end

  test "should redirect index to admin if logged in as staff" do
    sign_in @staff
    get conversations_url
    assert_redirected_to admin_conversations_path
  end

  test "should get new if logged in as user" do
    sign_in @user
    get new_conversation_url
    assert_response :success
  end

  test "should create conversation" do
    sign_in @user
    assert_difference('Conversation.count') do
      post conversations_url, params: { department: 'support' }
    end

    assert_redirected_to conversation_url(Conversation.last)
  end

  test "should not create conversation if staff" do
    sign_in @staff
    assert_no_difference('Conversation.count') do
      post conversations_url, params: { department: 'support' }
    end
    assert_redirected_to admin_conversations_path
  end
end
