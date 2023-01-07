# frozen_string_literal: true

module Turbo
  module Ruby
    module Helpers
      def action(...)
        self.class.action(...)
      end

      def self.action(name, target, content = nil, view_context: nil, allow_inferred_rendering: true, attributes: {},
                      **rendering, &block)
        TurboStreamElement.new(
          action: name,
          target: target,
          content: content,
          view_context: view_context,
          allow_inferred_rendering: allow_inferred_rendering,
          attributes: attributes,
          **rendering,
          &block
        )
      end

      def action_all(...)
        self.class.action_all(...)
      end

      def self.action_all
        # ...
      end

      def self.turbo_stream_action_tag
        # ...
      end

      def self.turbo_frame_tag
        # ...
      end
    end
  end
end
