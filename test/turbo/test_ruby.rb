# frozen_string_literal: true

require "test_helper"

module Turbo
  class TestRuby < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::Turbo::Ruby::VERSION
    end
  end
end
