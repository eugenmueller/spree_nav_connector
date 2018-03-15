SpreeNavConnector
=================

[![Build Status](https://travis-ci.org/eugenmueller/spree_nav_connector.svg?branch=master)](https://travis-ci.org/eugenmueller/spree_nav_connector)
[![Maintainability](https://api.codeclimate.com/v1/badges/fc3cbcd89affe1b0c38f/maintainability)](https://codeclimate.com/github/eugenmueller/spree_nav_connector/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/fc3cbcd89affe1b0c38f/test_coverage)](https://codeclimate.com/github/eugenmueller/spree_nav_connector/test_coverage)

Introduction goes here.

## Installation

1. Add this extension to your Gemfile with this line:
  ```ruby
  gem 'spree_nav_connector', github: '[your-github-handle]/spree_nav_connector'
  ```

2. Install the gem using Bundler:
  ```ruby
  bundle install
  ```

3. Copy & run migrations
  ```ruby
  bundle exec rails g spree_nav_connector:install
  ```

4. Restart your server

  If your server was running, restart it so that it can find the assets properly.

## Testing

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_nav_connector/factories'
```


## Contributing

If you'd like to contribute, please take a look at the
[instructions](CONTRIBUTING.md) for installing dependencies and crafting a good
pull request.

Copyright (c) 2018 [name of extension creator], released under the New BSD License
# spreee_nav_connector
