require 'spec_helper'
require 'json'

module RubyStackoverflow
  describe Client::ResponseData do
    it 'should response data fields' do
      data = JSON.parse(fixture("users.json").read, {:symbolize_names => true})
      response = Client::ResponseData.new(data, 'user')
      expect(response.data.count).to eq(1)
      expect(response.raw_data.count).to eq(1)
      expect(response.quota_max).to eq(10000)
      expect(response.quota_remaining).to eq(9996)
      expect(response.backoff).to be_nil
    end
  end
end
