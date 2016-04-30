VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.allow_http_connections_when_no_cassette = true
  c.hook_into :webmock # or :fakeweb
end

def configure_stackoverflow
  RubyStackoverflow.configure do |config|
    config.client_key = "pfllsDjWHeLGWoWIT5rRdA(("
    config.access_token = "L0J88cciBPHiGtIKCul6Gg))"
  end
end

def stub_get(url, params = {})
  stub_request(:get, stackoverflow_url(url, params))
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + "/" + file)
end

def json_response(file)
  {
    body: fixture(file),
    headers: {
      content_type: "application/json; charset=utf-8"
    }
  }
end

def stackoverflow_url(url, params)
  url = basic_stackoverflow_url + url + "?key=dsadsadasd999&site=stackoverflow"
  params.each do |k, v|
    url.concat("&#{k}=#{v}")
  end
  url
end

def basic_stackoverflow_url
  "https://api.stackexchange.com/2.2/"
end
