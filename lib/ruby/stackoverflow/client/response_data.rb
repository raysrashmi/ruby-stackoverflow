module Ruby
  module Stackoverflow
    class Client
      class ResponseData
        attr_reader :data, :has_more, :error

        def initialize(response, klass)
          if response[:items].nil?
            @error =  StackoverflowError.new(response)
          else
            @data = format_data(response[:items], klass)
            @has_more = response[:has_more]
          end
        end

        def format_data(data, klass)
          eval(klass.capitalize).parse_data(data)
        end
      end
    end
  end
end
