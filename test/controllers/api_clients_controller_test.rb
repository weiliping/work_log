require 'test_helper'

class ApiClientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_client = api_clients(:one)
  end

  test "should get index" do
    get api_clients_url
    assert_response :success
  end

  test "should get new" do
    get new_api_client_url
    assert_response :success
  end

  test "should create api_client" do
    assert_difference('ApiClient.count') do
      post api_clients_url, params: { api_client: { app_secret: @api_client.app_secret, app_token: @api_client.app_token, is_active: @api_client.is_active, name: @api_client.name } }
    end

    assert_redirected_to api_client_url(ApiClient.last)
  end

  test "should show api_client" do
    get api_client_url(@api_client)
    assert_response :success
  end

  test "should get edit" do
    get edit_api_client_url(@api_client)
    assert_response :success
  end

  test "should update api_client" do
    patch api_client_url(@api_client), params: { api_client: { app_secret: @api_client.app_secret, app_token: @api_client.app_token, is_active: @api_client.is_active, name: @api_client.name } }
    assert_redirected_to api_client_url(@api_client)
  end

  test "should destroy api_client" do
    assert_difference('ApiClient.count', -1) do
      delete api_client_url(@api_client)
    end

    assert_redirected_to api_clients_url
  end
end
