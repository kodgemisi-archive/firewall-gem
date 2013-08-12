module Firewall
  module DashboardHelper
    class << self

      def blacklisting_active?
        return IptablesHelper.show_rules.include?("blacklistdrop")
      end
    
    end
  end
end
