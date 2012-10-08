# Gbwd

A little Gem to help eliminate website distractions.  It basically routes any requests for the domains that are being blocked to [http://getbacktoworkdummy.com](http://getbacktoworkdummy.com "http://getbacktoworkdummy.com")

## Installation

Add this line to your application's Gemfile:

    gem 'gbwd'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gbwd

## Usage

*NOTE: Please back up your /etc/hosts file before running any commands.*

Add a domain to be blocked:
	
	sudo gbwd add -d www.youtube.com
	
Remove a domain from being blocked:

	sudo gbwd remove -d www.youtube.com
	
List all domains being blocked:

	sudo gbwd list
	
Stop all domains from being blocked:

	sudo gbwd disable
	
Start blocking all domains again:

	sudo gbwd enable

## Todos
1. Make a copy of /etc/hosts file before modifying it


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
