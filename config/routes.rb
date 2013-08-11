Firewall::Engine.routes.draw do

	match 'dashboard' => "dashboard#index", :via => [:get]

	resource :rule
	delete "rules/reset"

	root "dashboard#index"
end
