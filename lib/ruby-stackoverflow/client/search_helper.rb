module RubyStackoverflow
  class Client
    module SearchHelper

      def similar(title, options={})
        similar_response(title, options)
      end

      private

      def similar_response(title, options={})
        getr 'similar', 'question', options.merge(title: title)
      end

    end
  end
end