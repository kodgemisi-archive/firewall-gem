module Firewall
  module UrlProtectionsHelper

    class << self
      def protected_urls
        regex = /\d+\s+ACCEPT.*?dpt:80 STRING match  "(.*?)" ALGO/
        rules = IptablesHelper.show_rules.split(/\n/)

        protected_urls = []
        rules.each{ |line|
          match = regex.match(line)
          protected_urls.push(match[1]) unless match.nil?
        }

        return protected_urls
      end
    end
  end
end
