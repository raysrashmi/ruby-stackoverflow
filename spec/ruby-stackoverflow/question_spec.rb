require "spec_helper"

module RubyStackoverflow
  describe Client::QuestionHelper do
    before(:each) do
      configure_stackoverflow
      @question_basic_url = "questions/"
    end

    it "should get questions" do
      VCR.use_cassette("questions") do
        response = RubyStackoverflow.questions

        expect(response.data.is_a?(Array)).to be_truthy
        expect(response.data.last.respond_to?(:answer_count)).to be_truthy
      end
    end

    it "should get questions by id" do
      VCR.use_cassette("questions_by_ids") do
        response = RubyStackoverflow.questions_by_ids(["19294359"])

        expect(response.data.is_a?(Array)).to be_truthy
        expect(response.data.last.respond_to?(:answer_count)).to be_truthy
      end
    end

    it "should get answers of questions" do
      VCR.use_cassette("questions_answers") do
        response = RubyStackoverflow.answers_of_questions(%w(16067043 19401289))

        expect(response.data.is_a?(Array)).to be_truthy
        expect(response.data.last.answers.count).to eq(1)
        expect(response.data.first.answers.last.answer_id).to eq(19_401_432)
      end
    end

    it "should get comments of questions" do
      VCR.use_cassette("questions_comments") do
        response = RubyStackoverflow.comments_of_questions(["13804832"])
        data = response.data.last

        expect(response.data.is_a?(Array)).to be_truthy
        expect(data.respond_to?(:comments)).to be_truthy
        expect(data.comments.first.owner[:user_id]).to eq(87_189)
      end
    end

    it "should get linked questions" do
      VCR.use_cassette("linked_questions") do
        response = RubyStackoverflow.linked_questions(["13804832"])

        expect(response.data.is_a?(Array)).to be_truthy
      end
    end

    it "should get related questions" do
      VCR.use_cassette("related_questions") do
        response = RubyStackoverflow.related_questions(["13804832"])

        expect(response.data.is_a?(Array)).to be_truthy
      end
    end

    it "should get timeline questions" do
      VCR.use_cassette("timeline_questions") do
        response = RubyStackoverflow.timeline_of_questions(%w(13804832 16067043))
        data = response.data.first

        expect(response.data.is_a?(Array)).to be_truthy
        expect(data.posts.first.respond_to?(:timeline_type)).to be_truthy
        expect(data.posts.first.timeline_type).to eq("comment")
      end
    end

    it "should get featured questions" do
      VCR.use_cassette("featured_questions") do
        response = RubyStackoverflow.featured_questions(page: 1, pagesize: 1)

        expect(response.data.is_a?(Array)).to be_truthy
      end
    end

    it "should get unanswered questions" do
      VCR.use_cassette("unanswered_questions") do
        response = RubyStackoverflow.unanswered_questions(tagged: "rails", pagesize: 1, page: 1)

        expect(response.data.is_a?(Array)).to be_truthy
      end
    end

    it "should get noanswered questions" do
      VCR.use_cassette("noanswered_questions") do
        response = RubyStackoverflow.noanswered_questions(tagged: "rails", pagesize: 1, page: 1)

        expect(response.data.is_a?(Array)).to be_truthy
      end
    end
  end
end
