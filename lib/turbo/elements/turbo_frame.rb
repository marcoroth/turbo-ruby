# frozen_string_literal: true

module Turbo
  module Elements
    class TurboFrame < Phlex::HTML
      register_element :turbo_frame

      def initialize(src:, loading:, disabled:, target:, autoscroll:)
        @src = src
        @loading = loading
        @disabled = disabled
        @target = target
        @autoscroll = autoscroll
      end

      def template(&content)
        turbo_frame(
          src: @src,
          loading: @loading,
          disabled: @disabled,
          target: @target,
          autoscroll: @autoscroll,
          &content
        )
      end
    end
  end
end
