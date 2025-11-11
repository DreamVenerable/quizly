# frozen_string_literal: true

module Quizly
  class Configuration
    attr_accessor :default_locale, :shuffle_questions, :shuffle_choices

    def initialize
      self.default_locale = :en
      self.shuffle_questions = true
      self.shuffle_choices = true
    end
  end
end
