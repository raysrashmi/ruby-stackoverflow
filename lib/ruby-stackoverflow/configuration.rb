module RubyStackoverflow
  class Configuration
    attr_accessor(
      :site,
      :client_id,
      :client_secret,
      :client_key,
      :access_token,
      :api_url)

    def self.api_url
      "https://api.stackexchange.com/2.2/"
    end
  end
end
