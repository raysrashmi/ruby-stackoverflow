module RubyStackoverflow
  class Client
    module BadgesHelper
      def badges(options = {})
        badges_response(options)
      end

      def badges_by_ids(ids, options = {})
        url = join_ids(ids)
        badges_response(options, url)
      end

      def badges_by_ids(ids, options = {})
        url = join_ids(ids)
        badges_response(options, url)
      end

      def badges_by_name(options = {})
        url = "/name"
        badges_response(options, url)
      end

      def badges_between_dates(options = {})
        url = "/recipients"
        badges_response(options, url)
      end

      def badges_between_dates_by_ids(ids, options = {})
        ids = join_ids(ids)
        url = ids + "/recipients"
        badges_response(options, url)
      end

      def badges_by_tags(options = {})
        url = "/tags"
        badges_response(options, url)
      end

      private

      def badges_response(options = {}, url= "")
        url = "badges/" + url
        getr(url, "badge", options)
      end
    end
  end
end
