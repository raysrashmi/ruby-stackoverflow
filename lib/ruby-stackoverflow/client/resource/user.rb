module RubyStackoverflow
  class Client
    class User < Resource
      USER_KEYS = [:owner, :user_id, :user, :proposing_user]
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
            if has_notification?(attr_hash)
              users << Notification.new(attr_hash)
            elsif has_user_data?(attr_hash)
              users << new(attr_hash)
            else
              user = create_user(attr_hash, users)

              user.badges.push(Badge.new(attr_hash))
              user.answers.push(Answer.new(attr_hash))
              user.comments.push(Comment.new(attr_hash))
              user.questions.push(Question.new(attr_hash))
              user.reputations.push(Reputation.new(attr_hash))
              user.tags.push(Tag.new(attr_hash))
              user.posts.push(Post.new(attr_hash))
              user.permissions.push(Permission.new(attr_hash))
              user.suggested_edits.push(SuggestedEdit.new(attr_hash))
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
          user_attr = attr_hash.delete(:owner) || attr_hash.delete(:user_id) || 
            attr_hash.delete(:user) ||
            attr_hash.delete(:proposing_user)

          user_attr = user_attr.is_a?(Hash) ? user_attr : {user_id: user_attr }
          find_or_create_user(users, user_attr)
        end

        def has_user_data?(attr_hash)
          attr_hash.include?(:display_name) &&
            attr_hash.include?(:profile_image)
        end

        def has_notification?(data)
          data.include?(:notification_type)
        end
      end
    end
  end
end
