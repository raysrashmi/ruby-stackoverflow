require 'spec_helper'
module Ruby
  module Stackoverflow
    describe Client::BadgesHelper do
      before(:each) do
        configure_stackoverflow
        @user_basic_url= 'badges/'
      end

      it 'should find badges' do
        VCR.use_cassette('badges') do
          response = Ruby::Stackoverflow.badges({min: 'gold', max: 'bronze', sort: 'rank'})
          response.data.is_a?(Array).should be_true
          expect(response.data.count).to eq(30)
          expect(response.data.first.name).to eq('cryptography')
        end
      end

      it 'should find badges by ids' do
        VCR.use_cassette('badges_by_ids') do
          response = Ruby::Stackoverflow.badges_by_ids([263, 264], {min: 'gold', max: 'bronze', sort: 'rank'})
          response.data.is_a?(Array).should be_true
          expect(response.data.count).to eq(2)
          expect(response.data.first.name).to eq('cryptography')
        end
      end

      it 'should find badges by name' do
        VCR.use_cassette('badges_by_name') do
          response = Ruby::Stackoverflow.badges_by_name({inname: 'teacher',min: 'gold', max: 'bronze', sort: 'rank'})
          response.data.is_a?(Array).should be_true
          expect(response.data.count).to eq(1)
          expect(response.data.first.name).to eq('Teacher')
        end
      end

      it 'should find recently added badges' do
        VCR.use_cassette('badges_by_recipients') do
          response = Ruby::Stackoverflow.badges_between_dates({page: 1, pagesize: 10})
          response.data.is_a?(Array).should be_true
          expect(response.data.count).to eq(10)
          expect(response.data.first.name).to eq('Nice Answer')
        end
      end

      it 'should find recently added badges by ids' do
        VCR.use_cassette('badges_by_recipients_by_ids') do
          response = Ruby::Stackoverflow.badges_between_dates_by_ids([146, 20],{page: 1, pagesize: 10})
          response.data.is_a?(Array).should be_true
          expect(response.data.count).to eq(10)
          expect(response.data.first.name).to eq('Nice Question')
        end
      end

      it 'should find badges by tags' do
        VCR.use_cassette('badges_by_tags') do
          response = Ruby::Stackoverflow.badges_by_tags({inname: 'ruby-on-rails',min: 'gold', max: 'bronze', sort: 'rank'})
          response.data.is_a?(Array).should be_true
          expect(response.data.count).to eq(7)
          expect(response.data.first.name).to eq('ruby-on-rails')
        end
      end
    end
  end
end
