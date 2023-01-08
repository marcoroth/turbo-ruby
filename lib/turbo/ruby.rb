# frozen_string_literal: true

require "phlex"

require_relative "ruby/version"
require_relative "ruby/helpers"
require_relative "elements"
require_relative "elements/turbo_stream"
require_relative "elements/turbo_frame"

module Turbo
  module Ruby
    module RegisteredStreamActions
      def self.register(name, action = name)
        define_method name do |*arguments, **options, &block|
          stream(*arguments, action: action, **options, &block)
        end
      end

      def stream(**options, &block)
        Turbo::Elements::TurboStream.new(**options, &block)
      end
    end

    class << self
      def registered_stream_actions
        RegisteredStreamActions
      end

      def stream_actions(&block)
        registered_stream_actions.module_eval(&block)
      end
    end

    stream_actions do
      register :morph

      def log(message, **options, &block)
        stream(action: "console_log", message: message, **options, &block)
      end
    end
  end

  # Make `Turbo.morph` etc. and `Turbo.stream` available.
  include Ruby.registered_stream_actions
end

require_relative "railtie" if defined?(Rails::Railtie)
