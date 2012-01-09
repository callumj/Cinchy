module Cinchy
  module Extensions
    module Bot
      def self.included(base)
        base.class_eval do
          attr_reader :events
        end
      end
    end
  end
end