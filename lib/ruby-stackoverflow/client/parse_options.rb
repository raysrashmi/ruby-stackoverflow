module RubyStackoverflow
  module ParseOptions
    def parse_options(options = {})
      options.each do|k,v|
        case k
        when :fromdate , :todate, :min, :max
          begin
            options[k] = Time.parse(v).to_i
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
