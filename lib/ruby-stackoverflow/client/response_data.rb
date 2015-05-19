module RubyStackoverflow
  class Client
    class ResponseData
      attr_reader :data, :has_more, :error, :raw_response, :raw_data, :quota_max, :quota_remaining, :backoff

      def initialize(response, klass)
        @raw_response = response
        if response[:items].nil?
          @error = StackoverflowError.new(response)
        else
          @data = format_data(response[:items], klass)
          @has_more = response[:has_more]
          @raw_data = response[:items]
          @quota_max = response[:quota_max]
          @quota_remaining = response[:quota_remaining]
          @backoff = response[:backoff]
        end
      end

      def format_data(data, klass)
        eval(klass.capitalize).parse_data(data)
      end
    end
  end
end
