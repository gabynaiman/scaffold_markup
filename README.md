# scaffold_markup

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'scaffold_markup'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scaffold_markup

## Usage

Put into aplication.js file

	//= require jquery.livequery
	//= require bootstrap

Put into application.css file

	*= require bootstrap
 	*= require scaffold_markup

All scaffold controller must include

	include ScaffoldMarkup::Controllers::Base

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request