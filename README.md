# Ruby::Stackoverflow [![Code Climate](https://codeclimate.com/github/raysrashmi/ruby-stackoverflow.png)](https://codeclimate.com/github/raysrashmi/ruby-stackoverflow)

Ruby toolkit to Stackoverflow API 

## Install

Add this line to your application's Gemfile:

    gem 'ruby-stackoverflow'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-stackoverflow

###Documentation

<a href='https://github.com/raysrashmi/ruby-stackoverflow/wiki/Users-calls'>User Calls</a>
<br/>
<a href='https://github.com/raysrashmi/ruby-stackoverflow/wiki/Questions-Calls'>Questions Calls</a>
<br/>
<a href='https://github.com/raysrashmi/ruby-stackoverflow/wiki/Badges-calls'>Badges Calls</a>
<br/>
<a href='https://github.com/raysrashmi/ruby-stackoverflow/wiki/Comments-calls'>Comments Calls</a>
<br/>

##Configuration

You can add your key and access-token for higher rate limit.
To get Key and Access Token you have to register your app to http://stackapps.com/
Run command in your application dir.

    $ rails generate ruby_stackoverflow --client_key=<key> --access_token=<access token>

This command will create a ruby_stackoverflow.rb file in config/initializers.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

##LICENSE

