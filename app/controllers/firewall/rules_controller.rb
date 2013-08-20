# Copyright 2013 Destan Sarpkaya [destan@kodgemisi.com]
#
# firewall-gem is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# firewall-gem is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with firewall-gem.  If not, see <http://www.gnu.org/licenses/>.

require_dependency "firewall/application_controller"

module Firewall
  class RulesController < ApplicationController

    def create
      @message = IptablesHelper.add_rule(params[:rule])
      p "message: #{@message}"
      render 'firewall/dashboard/index'
    end

    def remove
      @message = IptablesHelper.remove_rule(params[:index])
      p "message: #{@message}"
      @message = "#{@message}<br>Check if url is really removed. Note that if the url is removed the rule indexes have been shifted!"
      render 'firewall/dashboard/index'
    end

    def reset
      @message = IptablesHelper.reset_rules
      p "message: #{@message}"
      render 'firewall/dashboard/index'
    end

    def protect_url
      url = params[:url]
      interval = params[:interval]
      hitcount = params[:hitcount]
      url_list_name = url.gsub(/[^a-zA-Z0-9]/,'') + '_URL_LIST'

      # If a packet is from a host that is in the list and exceeding limits then forward to blacklistdrop to be blacklisted and then dropped
      send_to_blacklist_rule = "-A INPUT -p tcp --dport 80 --match string --string #{url} --algo kmp  --match recent --update --name #{url_list_name} --seconds #{interval} --hitcount #{hitcount} -j blacklistdrop"

      # If a packet is from a host playing good so far, add to "xscores" list and accept 
      add_to_list_and_accept_rule = "-A INPUT -p tcp --dport 80 --match string --string #{url} --algo kmp  --match recent --set --name #{url_list_name} -j ACCEPT"
      
      r1 = IptablesHelper.add_rule(send_to_blacklist_rule)
      r2 = IptablesHelper.add_rule(add_to_list_and_accept_rule)
      @message = r1 + r2

      @message = @message.strip == '' ? "Success" : @message

      render 'firewall/dashboard/index'
    end
  end
end
