module RubyStackoverflow
  class Client
    class StackoverflowError
      attr_reader :error_code, :error_message, :error_name

      def initialize(params)
        @error_name = params[:error_name]
        @error_code = params[:error_id]
        @error_message = params[:error_message]
      end
    end
  end
end
