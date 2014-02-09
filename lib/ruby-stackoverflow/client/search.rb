module RubyStackoverflow
  class Client
    module Search
      def search(options = {})
        url = 'search/advanced'
        search_response(url, options)
      end
      private

      def search_response(url, options = {})
        getr(url,'question',options)
      end

    end
  end
end
