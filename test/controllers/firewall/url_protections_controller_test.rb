require 'test_helper'

module Firewall
  class UrlProtectionsControllerTest < ActionController::TestCase
    setup do
      @url_protection = url_protections(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:url_protections)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create url_protection" do
      assert_difference('UrlProtection.count') do
        post :create, url_protection: {  }
      end

      assert_redirected_to url_protection_path(assigns(:url_protection))
    end

    test "should show url_protection" do
      get :show, id: @url_protection
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @url_protection
      assert_response :success
    end

    test "should update url_protection" do
      patch :update, id: @url_protection, url_protection: {  }
      assert_redirected_to url_protection_path(assigns(:url_protection))
    end

    test "should destroy url_protection" do
      assert_difference('UrlProtection.count', -1) do
        delete :destroy, id: @url_protection
      end

      assert_redirected_to url_protections_path
    end
  end
end
