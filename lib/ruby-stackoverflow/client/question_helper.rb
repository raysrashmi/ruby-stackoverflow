module RubyStackoverflow
  class Client
    module QuestionHelper
      def questions(options = {})
        question_response(options)
      end

      def questions_by_ids(ids , options = {})
        url = join_ids(ids)
        question_response(options, url)
      end

      def answers_of_questions(ids, options={})
        url = join_ids(ids) + '/answers'
        question_response(options, url)
      end

      def comments_of_questions(ids, options={})
        url = join_ids(ids) + '/comments'
        question_response(options, url)
      end

      def linked_questions(ids, options={})
        url = join_ids(ids)+'/linked'
        question_response(options, url)
      end

      def related_questions(ids, options={})
        url= join_ids(ids) + '/related'
        question_response(options, url)
      end

      def timeline_of_questions(ids, options={})
        url = join_ids(ids) + '/timeline'
        question_response(options, url)
      end

      def featured_questions(options={})
        url = 'featured'
        question_response(options, url)
      end

      def unanswered_questions(options={})
        question_response(options, 'unanswered')
      end

      def noanswered_questions(options={})
        question_response(options, 'no-answers')
      end

      private

      def question_response(options={}, url='')
        url = 'questions/' + url
        getr(url, 'question', options)
      end
    end
  end
end
