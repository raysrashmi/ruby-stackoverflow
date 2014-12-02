module Ruby
  module Stackoverflow
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
              if data_has_badge?(attr_hash)
                user = create_user(attr_hash, users, :user)
                user.badges.push(Badge.new(attr_hash))
              elsif data_has_answer?(attr_hash)
                user = create_user(attr_hash, users)
                user.answers.push(Answer.new(attr_hash))
              elsif data_has_comment?(attr_hash)
                user = create_user(attr_hash, users)
                user.comments.push(Comment.new(attr_hash))
              elsif data_has_question?(attr_hash)
                user = create_user(attr_hash, users)
                user.questions.push(Question.new(attr_hash))
              elsif data_has_reputation?(attr_hash)
                user = create_user(attr_hash, users, :user_id)
                user.reputations.push(Reputation.new(attr_hash))
              elsif data_has_suggested_edit?(attr_hash)
                user = create_user(attr_hash, users, :proposing_user)
                user.suggested_edits.push(SuggestedEdit.new(attr_hash))
              elsif data_has_tag_name?(attr_hash)
                user = create_user(attr_hash, users, :user_id)
                user.tags.push(Tag.new(attr_hash))
              elsif data_has_timeline?(attr_hash)
                user = create_user(attr_hash, users, :user_id)
                user.posts.push(Post.new(attr_hash))
              elsif data_has_permission_object?(attr_hash)
                user = create_user(attr_hash, users, :user_id)
                user.permissions.push(Permission.new(attr_hash))
              elsif data_has_notification?(attr_hash)
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
            !user_array.empty? ?  user_array.first : new(user_attr)
          end

          def create_user(attr_hash, users, hash_key=:owner)
            user_attr = attr_hash.delete(hash_key)
            user_attr = user_attr.is_a?(Hash) ? user_attr : {user_id: user_attr }
            user = find_or_create_user(users, user_attr)
            users << user unless user_exists?(users, user_attr[:user_id])
            user
          end

          def user_exists?(users, user_id)
            user_array = users.select{|u|u.user_id == user_id }
            !user_array.empty?
          end

          def data_has_badge?(data)
            data.include?(:badge_id)
          end

          def data_has_answer?(data)
            data.include?(:answer_id)
          end
          def data_has_comment?(data)
            data.include?(:comment_id) && !data.include?(:timeline_type)
          end

          def data_has_question?(data)
            data.include?(:question_id)
          end

          def data_has_reputation?(data)
            data.include?(:reputation_change)
          end

          def data_has_suggested_edit?(data)
            data.include?(:suggested_edit_id)
          end

          def data_has_tag_name?(data)
            data.include?(:name) || data_has_tag_score?(data)
          end

          def data_has_tag_score?(data)
            data.include?(:tag_name) && data.include?(:answer_score)
          end
          def data_has_timeline?(data)
            data.include?(:timeline_type)
          end

          def data_has_permission_object?(data)
            data.include?(:object_type)
          end

          def data_has_notification?(data)
            data.include?(:notification_type)
          end
        end
      end
    end
  end
end
