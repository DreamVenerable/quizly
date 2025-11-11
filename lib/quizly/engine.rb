# frozen_string_literal: true

require "rails/engine"

module Quizly
  class Engine < ::Rails::Engine
    isolate_namespace Quizly

    # Minimal generator settings; host app controls test framework
    config.generators do |g|
      g.test_framework :rspec
      g.assets false
      g.helper false
    end
  end
end
