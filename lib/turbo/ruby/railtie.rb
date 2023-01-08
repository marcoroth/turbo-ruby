# frozen_string_literal: true

module Turbo
  module Ruby
    class Railtie < Rails::Railtie
      initializer "turbo.ruby.view_helpers" do
        ActiveSupport.on_load :action_view do
          include Turbo::Ruby::ViewContextHelper
        end
      end
    end
  end
end
