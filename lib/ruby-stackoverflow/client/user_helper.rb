module RubyStackoverflow
  class Client
    module UserHelper
      def users(options = {})
        user_response(options)
      end

      def users_by_ids(ids, options = {})
        ids = join_ids(ids)
        user_response(options, ids)
      end

      def users_with_answers(ids, options = {})
        ids = join_ids(ids)
        url = ids + '/answers'
        user_response(options, url)
      end

      def users_with_badges(ids, options = {})
        ids = join_ids(ids)
        url = ids + '/badges'
        user_response(options, url)
      end

      def users_with_comments(ids, options = {})
        ids = join_ids(ids)
        url = ids + '/comments'
        user_response(options, url)
      end

      def users_with_replied_comments(ids, toid, options = {})
        ids = join_ids(ids)
        url = ids + '/comments/' + toid
        user_response(options, url)
      end

       def users_notifications(id, options = {})
        url = id + '/notifications'
        user_response(options, url)
      end

       def users_unread_notifications(id, options = {})
        url = id + '/notifications/unread'
        user_response(options, url)
      end
      
      def users_with_favorites_questions(ids, options = {})
        ids = join_ids(ids)
        url = ids + '/favorites'
        user_response(options, url)
      end

      def users_with_mentioned_comments(ids, options = {})
        ids = join_ids(ids)
        url = ids + '/mentioned'
        user_response(options, url)
      end

      def users_questions(ids, options = {})
        ids = join_ids(ids)
        url = ids + '/questions'
        user_response(options, url)
      end

      def users_featured_questions(ids, options = {})
        ids = join_ids(ids)
        url = ids + '/questions/featured'
        user_response(options, url)
      end

      def users_noanswers_questions(ids, options = {})
        ids = join_ids(ids)
        url = ids + '/questions/no-answers'
        user_response(options, url)
      end

      def users_unaccepted_questions(ids, options = {})
        ids = join_ids(ids)
        url = ids + '/questions/unaccepted'
        user_response(options, url)
      end

      def users_unanswered_questions(ids, options = {})
        ids = join_ids(ids)
        url = ids + '/questions/unanswered'
        user_response(options, url)
      end

      def users_reputations(ids, options = {})
        ids = join_ids(ids)
        url = ids + '/reputation'
        user_response(options, url)
      end

      def users_suggested_edits(ids, options = {})
        ids = join_ids(ids)
        url = ids + '/suggested-edits'
        user_response(options, url)
      end

      def users_tags(ids, options = {})
        ids = join_ids(ids)
        url = ids + '/tags'
        user_response(options, url)
      end

      def users_top_answers_with_given_tags(id, tags, options = {})
        url = id + '/tags/' + join_ids(tags) + '/top-answers'
        user_response(options, url)
      end

      def users_top_questions_with_given_tags(id, tags, options = {})
        url = id + '/tags/' + join_ids(tags) + '/top-questions'
        user_response(options, url)
      end

      def user_top_tags_by_answers(id, options ={})
        url = id + '/top-answer-tags'
        user_response(options, url)
      end

      def user_top_tags_by_questions(id, options ={})
        url = id + '/top-question-tags'
        user_response(options, url)
      end

      def users_timeline(ids, options = {})
        ids = join_ids(ids)
        url = ids + '/timeline'
        user_response(options, url)
      end

      def user_write_permissions(id, options = {})
        url = id + '/write-permissions'
        user_response(options, url)
      end

      def user_full_reputation_history(id, options = {})
        url = id + '/write-permissions'
        user_response(options, url)
      end

      private


      def user_response(options={}, url='')
        url =  'users/'+ url
        getr(url,'user',options)
      end
    end
  end
end
