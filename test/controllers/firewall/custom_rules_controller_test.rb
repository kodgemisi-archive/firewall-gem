require 'test_helper'

module Firewall
  class CustomRulesControllerTest < ActionController::TestCase
    setup do
      @custom_rule = custom_rules(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:custom_rules)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create custom_rule" do
      assert_difference('CustomRule.count') do
        post :create, custom_rule: {  }
      end

      assert_redirected_to custom_rule_path(assigns(:custom_rule))
    end

    test "should show custom_rule" do
      get :show, id: @custom_rule
      assert_response :success
    end

    test "should get edit" do
      get :edit, id: @custom_rule
      assert_response :success
    end

    test "should update custom_rule" do
      patch :update, id: @custom_rule, custom_rule: {  }
      assert_redirected_to custom_rule_path(assigns(:custom_rule))
    end

    test "should destroy custom_rule" do
      assert_difference('CustomRule.count', -1) do
        delete :destroy, id: @custom_rule
      end

      assert_redirected_to custom_rules_path
    end
  end
end
