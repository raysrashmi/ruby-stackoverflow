module RubyStackoverflow
  class Client
    class User < Resource
      attr_reader :badges, :answers, :comments, 
        :questions, :reputations,
        :suggested_edits, :tags, :posts, :permissions

      def initialize(attributes_hash)
        @badges =  []
        @answers = []
        @comments = []
        @questions = []
        @reputations = []
        @suggested_edits=[]
        @tags = []
        @posts = []
        @permissions = []
        super
      end

      class << self
        def parse_data(data)
          users = []
          data.each do|attr_hash|
            if has_badge?(attr_hash)
              user = create_user(attr_hash, users, :user)
              user.badges.push(Badge.new(attr_hash))
            elsif has_any_question_answer_or_comment?(attr_hash)
              user = create_user(attr_hash, users)
              user.answers.push(Answer.new(attr_hash))
              user.comments.push(Comment.new(attr_hash))
              user.questions.push(Question.new(attr_hash))
            elsif has_any_reputation_timeline_permission_or_name?(attr_hash)
              user = create_user(attr_hash, users, :user_id)
              user.reputations.push(Reputation.new(attr_hash))
              user.tags.push(Tag.new(attr_hash))
              user.posts.push(Post.new(attr_hash))
              user.permissions.push(Permission.new(attr_hash))
            elsif has_suggested_edit?(attr_hash)
              user = create_user(attr_hash, users, :proposing_user)
              user.suggested_edits.push(SuggestedEdit.new(attr_hash))
            elsif has_notification?(attr_hash)
              users << Notification.new(attr_hash)
            else
              users << new(attr_hash)
            end
          end
          users
        end

        private

        def find_or_create_user(users, user_attr)
          user_array = users.select{|u|u.user_id == user_attr[:user_id] }
          unless user_array.empty?
            user = user_array.first
          else
            user = new(user_attr)
            users << user
          end
          user
        end

        def create_user(attr_hash, users, hash_key=:owner) 
          user_attr = attr_hash.delete(:owner) || attr_hash.delete(:proposing_user) || attr_hash.delete(:user) || attr_hash.delete(:user_id)
          user_attr = user_attr.is_a?(Hash) ? user_attr : {user_id: user_attr } 
          find_or_create_user(users, user_attr) 
        end

        def has_badge?(data)
          data.include?(:badge_id)
        end

        def has_answer?(data)
          data.include?(:answer_id)
        end
        def has_comment?(data)
          data.include?(:comment_id) && !data.include?(:timeline_type)
        end

        def has_question?(data)
          data.include?(:question_id)
        end

        def has_reputation?(data)
          data.include?(:reputation_change)
        end

        def has_suggested_edit?(data)
          data.include?(:suggested_edit_id)
        end

        def has_tag_name?(data)
          data.include?(:name) || has_tag_score?(data)
        end

        def has_tag_score?(data)
          data.include?(:tag_name) && data.include?(:answer_score)
        end
        def has_timeline?(data)
          data.include?(:timeline_type)
        end

        def has_permission_object?(data)
          data.include?(:object_type)
        end

        def has_notification?(data)
          data.include?(:notification_type)
        end

        def has_any_question_answer_or_comment?(data)
           has_answer?(data) ||
             has_comment?(data) ||
             has_question?(data)
        end

        def has_any_reputation_timeline_permission_or_name?(data)
          has_reputation?(data)||
           has_tag_name?(data) ||
            has_timeline?(data) ||
            has_permission_object?(data)
        end

      end
    end
  end
end
