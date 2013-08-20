Firewall Admin Panel for Rails Servers
======================================

Usage
=====

Create `config/initializers/firewall.rb` file with following content

```
Firewall.config do |config| 
	config.sudo_password = '<sudo password here>'
end
```

Mount Firewall engine to your Rails application by adding followings to `routes.rb`


```
  firewall_constraint = lambda do |request|
    request.env['warden'].authenticate?
  end

  constraints firewall_constraint do
    mount Firewall::Engine => '/firewall'
  end
```

License
-------

LGPL