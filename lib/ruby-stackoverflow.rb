require "httparty"
require "ruby-stackoverflow/version"
require "ruby-stackoverflow/client"
require "ruby-stackoverflow/configuration"

module RubyStackoverflow
  include HTTParty

  class << self
    def client
      @client ||= RubyStackoverflow::Client.new
    end

    # @private
    def respond_to_missing?(method_name, include_private=false); client.respond_to?(method_name, include_private); end if RUBY_VERSION >= "1.9"
    # @private
    def respond_to?(method_name, include_private=false); client.respond_to?(method_name, include_private) || super; end if RUBY_VERSION < "1.9"

    private

    def method_missing(method_name, *args, &block)
      return super unless client.respond_to?(method_name)
      client.send(method_name, *args, &block)
    end
  end
end
