Firewall::Engine.routes.draw do

	match 'dashboard' => "dashboard#index", :via => [:get]
	match 'help' => "dashboard#help", :via => [:get]
	match 'dump' => "dashboard#dump_rules", :via => [:get]
	get "dashboard/activate_blacklisting"

	match 'url_protection' => "url_protections#index", :via => [:get]

	match 'custom_rules' => "custom_rules#index", :via => [:get]

	resource :rule
	delete "rules/reset"
	post "rules/remove"
	post "rules/protect_url"

	root "dashboard#index"
end
