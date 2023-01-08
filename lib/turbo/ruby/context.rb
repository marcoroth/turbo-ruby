# frozen_string_literal: true

module Turbo
  module Ruby
    class Context
      include Turbo::Ruby.registered_stream_actions

      attr_reader :view_context

      def initialize(view_context)
        @view_context = view_context
      end

      # turbo.targets(@posts).morph
      def targets(targets)
        if block_given?
          targets.each { yield Target.new(self, _1) }
        else
          Targets.new(self, targets)
        end
      end
      alias for targets # turbo.for(@post).morph or turbo.for(@posts).morph
      alias call targets # turbo.(@post).morph or turbo.(@posts).morph

      def target(record)
        Target.new(self, record).tap { yield _1 if block_given? }
      end

      # turbo.morph(@posts) or turbo.morph(@post)
      def stream(records, **options, &block)
        if records.respond_to?(:each)
          super(targets: records, **options, &block)
        else
          super(target: records, **options, &block)
        end
      end

      # <%= turbo.frame @post do %>
      # <% end %>
      def frame(record)
        Turbo::Elements::TurboFrame.new(to_dom_id(record)).tap { yield record if block_given? }
      end

      def to_dom_id(record)
        record.respond_to?(:to_key) ? @view_context.dom_id(record) : record
      end

      class Targets
        include Turbo::Ruby.registered_stream_actions

        attr_reader :context

        def initialize(context, targets)
          @context = context
          @targets = targets.map { context.to_dom_id(_1) }
        end

        def frame(&block)
          @targets.map { @context.frame(_1, &block) }
        end

        def stream(**options, &block)
          super(targets: @targets, **options, &block)
        end
      end

      class Target
        include Turbo::Ruby.registered_stream_actions

        attr_reader :context

        def initialize(context, target)
          @context = context
          @target = context.to_dom_id(target)
        end

        def frame(&block)
          @context.frame(@target, &block)
        end

        def stream(**options, &block)
          super(target: @target, **options, &block)
        end
      end
    end
  end
end
