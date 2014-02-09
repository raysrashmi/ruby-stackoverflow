require 'spec_helper'
module RubyStackoverflow
  describe Client::Search do
    before(:each) do
      configure_stackoverflow
    end

    it 'should find questions based on search terms' do
      VCR.use_cassette('search') do
        response = RubyStackoverflow.search({q: 'rails'})
        response.data.is_a?(Array).should be_true
        user = response.data.first
        expect(user.title).to eq('Two different compiled assets in Rails 4')
        expect(user.link).to eq('http://stackoverflow.com/questions/21666733/two-different-compiled-assets-in-rails-4')
      end
    end
  end
end
