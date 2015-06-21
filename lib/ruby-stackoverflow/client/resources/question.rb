module RubyStackoverflow
  class Client
    class Question < Resource
      attr_reader :answers , :comments,:user, :posts
      def initialize(attributes_hash={})
        @answers = []
        @comments = []
        @posts = []
        super
      end

      class << self
        def parse_data(data)
          questions = []
          data.each do|attr_hash|
            if data_has_answer?(data)
              question = create_question(attr_hash, questions, :question_id)
              question.answers.push(Answer.new(attr_hash))
            elsif data_has_comment?(data)
              question = create_question(attr_hash, questions,:post_id)
              question.comments.push(Comment.new(attr_hash))
            elsif data_has_timeline?(data)
              question = create_question(attr_hash, questions,:question_id)
              question.posts.push(Post.new(attr_hash))
            else
              questions << new(attr_hash)
            end
          end
          questions
        end

        def data_has_answer?(data)
          data.first.include?(:answer_id)
        end

        def data_has_comment?(data)
          data.first.include?(:comment_id) && !data.first.include?(:timeline_type)
        end

        def data_has_timeline?(data)
          data.first.include?(:timeline_type)
        end

        def find_or_create_question(questions, qid)
          question_array = questions.select{|q|q.question_id == qid}
          !question_array.empty? ?  question_array.first : new({question_id: qid})
        end


        def create_question(attr_hash, questions, hash_key)
          qid = attr_hash.delete(hash_key)
          question = find_or_create_question(questions, qid)
          questions << question unless question_exists?(questions,qid)
          question
        end

        def question_exists?(questions, question_id)
          question_array =  questions.select{|q|q.question_id == question_id }
          !question_array.empty?
        end
      end
    end
  end
end
