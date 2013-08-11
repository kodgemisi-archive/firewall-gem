Rails.application.routes.draw do

  mount Firewall::Engine => "/firewall"
end
