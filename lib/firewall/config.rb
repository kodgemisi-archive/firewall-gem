module Firewall
  module Config
    
    class << self
      attr_accessor :sudo_password

      def reset
        @@sudo_password = 'firewall_user_password'
      end
    end

    self.reset()
  end
end