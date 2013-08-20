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
