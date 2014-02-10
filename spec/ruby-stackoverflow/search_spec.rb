require 'spec_helper'
module RubyStackoverflow
  describe Client::Search do
    before(:each) do
      configure_stackoverflow
    end

    it 'should find questions based on search terms' do
      VCR.use_cassette('search') do
        response = RubyStackoverflow.search({q: 'ruby on rails'})
        response.data.is_a?(Array).should be_true
        user = response.data.first
        expect(user.title).to eq('Submit form directly from the controller')
        expect(user.link).to eq('http://stackoverflow.com/questions/21674703/submit-form-directly-from-the-controller')
      end
    end
  end
end
