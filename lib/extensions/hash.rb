module Cinchy
  module Extensions
    module Hash
      def self.included(base)
        base.extend ClassMethods
        base.class_eval do
          include InstanceMethods
        end
      end

      module ClassMethods
      end

      module InstanceMethods
        def to_ostruct
          self_copy = self.dup
          self_copy.each do |key, value|
            self_copy[key] = value.to_ostruct if value.is_a?(Hash)
          end
          OpenStruct.new(self_copy)
        end
      end
    end
  end
end