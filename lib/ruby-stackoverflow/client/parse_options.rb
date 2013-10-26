module RubyStackoverflow
  class Client
    module ParseOptions

      def parse_options(options = {})
        options.each do|k,v|
          case k
          when :fromdate , :todate, :min, :max
            begin
              options[k] = Date.parse(v).to_time.to_i
            rescue
              options[k] = v
            end
          else
            options[k] = v
          end
        end 
      end

      def join_ids(ids)
        ids.join(';')
      end
    end
  end
end
