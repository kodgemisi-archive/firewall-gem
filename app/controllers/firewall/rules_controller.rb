require_dependency "firewall/application_controller"

module Firewall
  class RulesController < ApplicationController

    def create
      @message = IptablesHelper.add_rule(params[:rule])
      p "message: #{@message}"
      render 'firewall/dashboard/index'
    end

    def reset
      @message = IptablesHelper.reset_rules
      p "message: #{@message}"
      render 'firewall/dashboard/index'
    end
  end
end
