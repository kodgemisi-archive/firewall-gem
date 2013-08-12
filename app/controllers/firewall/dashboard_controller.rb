require_dependency "firewall/application_controller"

module Firewall
  class DashboardController < ApplicationController

    def index
    end

    def help
    end

    def activate_blacklisting
      @message = "Blacklisting is already enabled!"
      if(!DashboardHelper.blacklisting_active?)
        # creates a new chain, blacklistdrop, which will log, update ip in the BLACKLIST and drop
        IptablesHelper.add_rule('-N blacklistdrop')
        IptablesHelper.add_rule('-A blacklistdrop -j LOG --log-prefix "Adding to BLACKLIST: "')
        IptablesHelper.add_rule('blacklistdrop -m recent --name BLACKLIST --set -j DROP')

        # A packet is from a host that has been seen in BLACKLIST the last 120 seconds, updates the BLACKLIST and is dropped.
        IptablesHelper.add_rule('-A INPUT -m recent --name BLACKLIST --update --seconds 120 -j DROP')
        @message = "Blacklisting support is activated but not functional until you add some 'blacklisting' rule. If you have already such rules ignore this message."
      end

      render 'firewall/dashboard/index'
    end

    def dump_rules
      date = Time.now.to_formatted_s(:number)
      headers['Content-Disposition'] = "attachment; filename=firewall_config_#{date}"
      render :text => IptablesHelper.get_rules(), :content_type => Mime::TEXT
    end

    def restore_rules
      uploaded_file = params[:file]

      if (uploaded_file.nil?)
        @message = "No file given!"
        render 'firewall/dashboard/index'
        return
      end

      file_content = uploaded_file.read
      
      if (file_content.nil? || file_content.strip == '')
        @message = "Empty file, no rule applied!"
        render 'firewall/dashboard/index'
        return
      end

      p file_content
      @message = IptablesHelper.apply_rules(file_content)
      render 'firewall/dashboard/index'
    end

  end
end
