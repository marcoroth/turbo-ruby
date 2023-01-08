# frozen_string_literal: true

module Turbo
  module Ruby
    class Context
      include Turbo::Ruby.stream_actions_context

      attr_reader :view_context

      def initialize(view_context)
        @view_context = view_context
      end

      def to_dom_id(record)
        record.respond_to?(:to_key) ? view_context.dom_id(record) : record
      end

      # turbo.morph(@posts) or turbo.morph(@post)
      def stream(records, **options, &block)
        if records.respond_to?(:each)
          super(targets: records, view_context: view_context, **options, &block)
        else
          super(target: records, view_context: view_context, **options, &block)
        end
      end
    end
  end
end
