require "firewall/engine"

module Firewall

  def self.config(&block)
    if block_given?
      block.call(Firewall::Config)
    else
      Firewall::Config
    end
  end

end
