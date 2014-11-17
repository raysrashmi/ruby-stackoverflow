module RubyStackoverflow
  class Client
    module TagHelper

      def tags(options={})
        tags_response(options)
      end

      private

      def tags_response(options={})
        getr 'tags/', 'tag', options
      end

    end
  end
end