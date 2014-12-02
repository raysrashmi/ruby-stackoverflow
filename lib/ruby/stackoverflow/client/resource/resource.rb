module Ruby
  module Stackoverflow
    class Client
      class Resource
        def initialize(attributes_hash)
          attributes_hash.each do|k,v|
            self.class.send :attr_accessor, k
            var = "@#{k}"
            case k.to_sym
            when :creation_date, :last_activity_date, :launch_date,:last_edit_date
              value = Time.at(v).utc.to_s
            else
              value = v
            end
            instance_variable_set(var, value)
          end
        end

        class << self
          def parse_data(data)
            datas = data.map do|attr_hash|
              new(attr_hash)
            end
            datas
          end
        end
      end
    end
  end
end
