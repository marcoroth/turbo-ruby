# frozen_string_literal: true

require "phlex"

require_relative "ruby/version"
require_relative "ruby/helpers"
require_relative "elements"
require_relative "elements/turbo_stream"
require_relative "elements/turbo_frame"

module Turbo
  module Ruby
    module StreamActionsContext
      def self.register(name, action = name)
        define_method name do |*arguments, **options, &block|
          stream(*arguments, action: action, **options, &block)
        end
      end

      # turbo.targets(@posts).morph
      def targets(targets)
        if block_given?
          targets.each { yield Turbo::Ruby::Target.new(self, _1) }
        else
          Turbo::Ruby::Targets.new(self, targets)
        end
      end
      alias for targets # Turbo.for(@post).morph or Turbo.for(@posts).morph
      alias call targets # Turbo.(@post).morph or Turbo.(@posts).morph

      def target(record)
        Turbo::Ruby::Target.new(self, record).tap { yield _1 if block_given? }
      end

      # <%= turbo.frame "post_1" do %>
      # <% end %>
      def frame(record)
        Turbo::Elements::TurboFrame.new(to_dom_id(record)).tap { yield record if block_given? }
      end

      def to_dom_id(record)
        record
      end

      def stream(**options, &block)
        Turbo::Elements::TurboStream.new(**options, &block)
      end
    end

    class << self
      def stream_actions_context
        StreamActionsContext
      end

      def stream_actions(&block)
        stream_actions_context.module_eval(&block)
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
  include Ruby.stream_actions_context

  class Targets
    include Turbo::Ruby.stream_actions_context

    undef_method :targets
    undef_method :target

    def initialize(context, targets)
      @context = context
      @targets = targets.map { context.to_dom_id(_1) }
    end

    def frame(&block)
      @targets.map { @context.frame(_1, &block) }
    end

    def stream(**options, &block)
      @context.stream(targets: @targets, **options, &block)
    end
  end

  class Target
    include Turbo::Ruby.stream_actions_context

    undef_method :targets
    undef_method :target

    def initialize(context, target)
      @context = context
      @target = context.to_dom_id(target)
    end

    def frame(&block)
      @context.frame(@target, &block)
    end

    def stream(**options, &block)
      @context.stream(target: @target, **options, &block)
    end
  end
end

require_relative "ruby/railtie" if defined?(Rails::Railtie)
