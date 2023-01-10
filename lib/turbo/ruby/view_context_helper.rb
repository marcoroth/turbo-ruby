# frozen_string_literal: true

module Turbo
  module Ruby
    module ViewContextHelper
      def turbo
        @turbo ||= Turbo::Ruby::Context.new(self)
      end
    end
  end
end
