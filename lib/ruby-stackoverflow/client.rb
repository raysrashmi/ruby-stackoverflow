require 'json'
require 'uri'
require 'ruby-stackoverflow/client/response_data'
require 'ruby-stackoverflow/client/resource/resource'
require 'ruby-stackoverflow/client/resource/user'
require 'ruby-stackoverflow/client/resource/question'
require 'ruby-stackoverflow/client/resource/answer'
require 'ruby-stackoverflow/client/resource/notification'
require 'ruby-stackoverflow/client/resource/badge'
require 'ruby-stackoverflow/client/resource/reputation'
require 'ruby-stackoverflow/client/resource/suggested_edit'
require 'ruby-stackoverflow/client/resource/comment'
require 'ruby-stackoverflow/client/resource/tag'
require 'ruby-stackoverflow/client/resource/post'
require 'ruby-stackoverflow/client/resource/permission'
require 'ruby-stackoverflow/client/resource/stackoverflow_error'
require 'ruby-stackoverflow/client/resource/search'
require 'ruby-stackoverflow/client/user_helper'
require 'ruby-stackoverflow/client/question_helper'
require 'ruby-stackoverflow/client/badges_helper'
require 'ruby-stackoverflow/client/comments_helper'
require 'ruby-stackoverflow/client/search_helper'
require 'ruby-stackoverflow/client/parse_options'

module RubyStackoverflow
  class Client
    include RubyStackoverflow::Client::ParseOptions
    include RubyStackoverflow::Client::UserHelper
    include RubyStackoverflow::Client::QuestionHelper
    include RubyStackoverflow::Client::BadgesHelper
    include RubyStackoverflow::Client::CommentsHelper
    include RubyStackoverflow::Client::SearchHelper

    attr_accessor :configuration

    def getr(url,klass, options={})
      request :get, url,klass ,options
    end

    def configure
      yield(configuration)
    end

    private

    def request(method, url, klass, options={})
      url = append_params_to_url(url, parse_options(options))
      response = HTTParty.send(method,url)
      parse_response(response, klass)
    end

    def parse_response(data, klass)
      data = JSON.parse(data.body, symbolize_names: true)
      ResponseData.new(data, klass)
    end

    def append_params_to_url(url, options)
      url = Configuration.api_url + url
      options.merge!(key_params)
      options = URI.encode_www_form(options)
      url+'?'+options
    end

    def key_params
      {key: configuration.client_key, site: 'stackoverflow', access_token: configuration.access_token}
    end

    def configuration
      @configuration||= Configuration.new
    end
  end
end
