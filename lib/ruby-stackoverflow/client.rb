require 'json'

require_relative 'client/response_data'
require_relative 'client/resources'
require_relative 'client/user_helper'
require_relative 'client/question_helper'
require_relative 'client/badges_helper'
require_relative 'client/comments_helper'
require_relative 'client/parse_options'

module RubyStackoverflow
  class Client
    include ParseOptions
    include UserHelper
    include QuestionHelper
    include BadgesHelper
    include CommentsHelper

    attr_accessor :configuration

    def getr(url, klass, options = {})
      request :get, url, klass, options
    end

    def configure
      yield(configuration)
    end

    private

    def request(method, url, klass, options = {})
      url = append_params_to_url(url, parse_options(options))
      response = HTTParty.send(method, url)
      parse_response(response, klass)
    end

    def parse_response(data, klass)
      data = JSON.parse(data.body, symbolize_names: true)
      ResponseData.new(data, klass)
    end

    def append_params_to_url(url, options)
      url = Configuration.api_url + url
      options.merge!(key_params)
      options = options.to_a.map { |k, v| "#{k}=#{v}" }
      url + '?' + options.join('&')
    end

    def key_params
      {
        key: configuration.client_key,
        site: 'stackoverflow',
        access_token: configuration.access_token,
      }
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
