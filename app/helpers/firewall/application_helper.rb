module Firewall
  module ApplicationHelper

  	class << self
	  	def get_tab_active_class_for(tab)
	  		p request.original_url
	  		return 'active'
	  	end
  	end
  end
end
