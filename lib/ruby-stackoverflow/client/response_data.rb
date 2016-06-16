module RubyStackoverflow
  class Client
    class ResponseData
      attr_reader :has_more, :error, :raw_response, :raw_data, :quota_max, :quota_remaining, :backoff

      def initialize(response, klass)
        @raw_response = response
        if response[:items].nil?
          @error = StackoverflowError.new(response)
        else
          @klass = klass
          @raw_data = response[:items]
          @has_more = response[:has_more]
          @quota_max = response[:quota_max]
          @quota_remaining = response[:quota_remaining]
          @backoff = response[:backoff]
        end
      end

      def data
        return nil if @raw_data.nil?
        @data ||= format_data(@raw_data.clone, @klass)
      end

      def format_data(data, klass)
        RubyStackoverflow::Client.const_get(klass.capitalize).parse_data(data)
      end
    end
  end
end
