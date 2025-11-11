# frozen_string_literal: true

require_relative "quizly/version"
require_relative "quizly/configuration"
require_relative "quizly/engine" if defined?(Rails)

module Quizly
  class Error < StandardError; end

  # Configuration API
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
