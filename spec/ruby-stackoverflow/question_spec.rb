require 'spec_helper'

module RubyStackoverflow
  describe Client::QuestionHelper do
    before(:each) do
      configure_stackoverflow
      @question_basic_url = 'questions/'
    end

    it 'should get questions' do
      VCR.use_cassette('questions') do
        response = RubyStackoverflow.questions
        response.data.is_a?(Array).should be_true
        response.data.last.respond_to?(:answer_count).should be_true
      end
    end

    it 'should get questions by id' do
      VCR.use_cassette('questions_by_ids') do
        response = RubyStackoverflow.questions_by_ids(['19294359'])
        response.data.is_a?(Array).should be_true
        response.data.last.respond_to?(:answer_count).should be_true
      end
    end

    it 'should get answers of questions' do
      VCR.use_cassette('questions_answers') do
        response = RubyStackoverflow.answers_of_questions(['16067043','19401289'])
        response.data.is_a?(Array).should be_true
        expect(response.data.last.answers.count).to eq(1)
        expect(response.data.first.answers.last.answer_id).to eq(19401432)
      end
    end

    it 'should get comments of questions' do
      VCR.use_cassette('questions_comments') do
        response = RubyStackoverflow.comments_of_questions(['13804832'])
        data = response.data.last
        response.data.is_a?(Array).should be_true
        data.respond_to?(:comments).should be_true
        expect(data.comments.first.owner[:user_id]).to eq(87189)
      end
    end

    it 'should get linked questions' do
      VCR.use_cassette('linked_questions') do
        response = RubyStackoverflow.linked_questions(['13804832'])
        response.data.is_a?(Array).should be_true
      end
    end

    it 'should get related questions' do
      VCR.use_cassette('related_questions') do
        response = RubyStackoverflow.related_questions(['13804832'])
        response.data.is_a?(Array).should be_true
      end
    end

    it 'should get timeline questions' do
      VCR.use_cassette('timeline_questions') do
        response = RubyStackoverflow.timeline_of_questions(['13804832','16067043'])
        data = response.data.first
        response.data.is_a?(Array).should be_true
        data.posts.first.respond_to?(:timeline_type).should be_true
        expect(data.posts.first.timeline_type).to eq('comment')
      end
    end

    it 'should get featured questions' do
      VCR.use_cassette('featured_questions') do
        response = RubyStackoverflow.featured_questions({page: 1,pagesize: 1})
        response.data.is_a?(Array).should be_true
      end
    end

    it 'should get unanswered questions' do
      VCR.use_cassette('unanswered_questions') do
        response = RubyStackoverflow.unanswered_questions({tagged:'rails',pagesize: 1, page: 1})
        response.data.is_a?(Array).should be_true
      end
    end

    it 'should get noanswered questions' do
      VCR.use_cassette('noanswered_questions') do
        response = RubyStackoverflow.noanswered_questions({tagged:'rails', pagesize: 1, page: 1})
        response.data.is_a?(Array).should be_true
      end
    end
  end
end
