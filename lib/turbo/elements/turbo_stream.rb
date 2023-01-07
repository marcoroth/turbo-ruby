# frozen_string_literal: true

module Turbo
  module Elements
    class TurboStream < Phlex::HTML
      register_element :turbo_stream

      def initialize(view_context: nil, action: nil, target: nil, content: nil, allow_inferred_rendering: true,
                     attributes: {}, **rendering, &block)
        super
        @view_context = view_context
        @action = action
        @target = target
        @content = content
        @allow_inferred_rendering = allow_inferred_rendering
        @attributes = attributes
        @rendering = rendering
        @block = block
      end

      def template(&block)
        content = render_template(&block)

        turbo_stream action: @action, target: @target, **@attributes do
          if @block || content
            template_tag do
              unsafe_raw content if content
              unsafe_raw @block.call if @block
            end
          end
        end
      end

      def render_template(&block)
        if @content
          @allow_inferred_rendering ? (render_record(@content) || @content) : @content
        elsif block_given?
          throw "no view_context error" if @view_context.nil?
          @view_context.capture(&block)
        elsif @rendering.any?
          throw "no view_context error" if @view_context.nil?
          @view_context.render(formats: [:html], **@rendering)
        elsif @allow_inferred_rendering
          render_record(@target)
        end
      end

      def render_record(possible_record)
        return unless possible_record.respond_to?(:to_partial_path)

        throw "no view_context error" if @view_context.nil?
        record = possible_record
        @view_context.render(partial: record, formats: :html)
      end
    end
  end
end
