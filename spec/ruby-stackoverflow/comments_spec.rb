require "spec_helper"
module RubyStackoverflow
  describe Client::CommentsHelper do
    before(:each) do
      configure_stackoverflow
      @comments_basic_url = "users/"
      WebMock.allow_net_connect!
    end

    it "should fetch comments" do
      VCR.use_cassette("comments") do
        response = RubyStackoverflow.comments(min: 1, max: 10, sort: "votes")

        expect(response.data.is_a?(Array)).to be_truthy
        expect(response.data.count).to eq(30)
        expect(response.data.first.edited).to eq(false)
        expect(response.data.first.score).to eq(10)
      end
    end

    it "should fetch comments by ids" do
      VCR.use_cassette("comments_by_ids") do
        response = RubyStackoverflow.comments_by_ids(%w(129085 131326))

        expect(response.data.is_a?(Array)).to be_truthy
        expect(response.data.count).to eq(2)
        expect(response.data.first.edited).to eq(false)
        expect(response.data.first.score).to eq(10)
      end
    end
  end
end
