module LolFramework
  class Common

    def iterate!
      yield self if block_given?
    end

    def self.defaulted_attributes(attributes)
      attributes.each do |attr, default|
        attr_writer attr

        define_method(attr) do
          variable = instance_variable_get("@#{attr}")
          variable ||= default if variable.nil?
          variable
        end
      end
    end
  end
end