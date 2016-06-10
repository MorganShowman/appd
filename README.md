# Appd

Docker compose wrapper to manage multiple apps.

Appd uses [direnv](http://direnv.net/) to execute docker-compose
commands in isolation while using the app's own environment.

## Installation

Install [direnv](http://direnv.net/) if you haven't already.

Add this line to your application's Gemfile:

```ruby
gem 'appd'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install appd

## Usage

```sh
# Setup $APP_PATH
export APP_PATH /path/to/your/apps

# See help
appd help
Usage:
  appd APPNAME command

Commands:
  help                         # Show this help
  ps                           # List containers
  build SERVICES               # Build or rebuild services
  up SERVICES                  # Create and start services
  stop SERVICES                # Stop services
  restart SERVICES             # Restart services
  exec SERVICE COMMAND         # Execute a command in a running container

Note: appd looks for apps in the $APP_PATH directory.
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MorganShowman/appd. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

