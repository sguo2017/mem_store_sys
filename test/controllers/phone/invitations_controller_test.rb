require 'test_helper'

class Phone::InvitationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @phone_invitation = phone_invitations(:one)
  end

  test "should get index" do
    get phone_invitations_url
    assert_response :success
  end

  test "should get new" do
    get new_phone_invitation_url
    assert_response :success
  end

  test "should create phone_invitation" do
    assert_difference('Phone::Invitation.count') do
      post phone_invitations_url, params: { phone_invitation: {  } }
    end

    assert_redirected_to phone_invitation_url(Phone::Invitation.last)
  end

  test "should show phone_invitation" do
    get phone_invitation_url(@phone_invitation)
    assert_response :success
  end

  test "should get edit" do
    get edit_phone_invitation_url(@phone_invitation)
    assert_response :success
  end

  test "should update phone_invitation" do
    patch phone_invitation_url(@phone_invitation), params: { phone_invitation: {  } }
    assert_redirected_to phone_invitation_url(@phone_invitation)
  end

  test "should destroy phone_invitation" do
    assert_difference('Phone::Invitation.count', -1) do
      delete phone_invitation_url(@phone_invitation)
    end

    assert_redirected_to phone_invitations_url
  end
end
