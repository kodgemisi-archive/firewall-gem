Firewall::Engine.routes.draw do

	match 'dashboard' => "dashboard#index", :via => [:get]
	get "dashboard/activate_blacklisting"

	resource :rule
	delete "rules/reset"
	post "rules/remove"
	post "rules/protect_url"

	root "dashboard#index"
end
