# frozen_string_literal: true

module Quizly
  class Quiz < ApplicationRecord
    has_many :questions, dependent: :destroy
    has_many :attempts, dependent: :destroy

    validates :title, presence: true

    def shuffled_questions
      Quizly.configuration.shuffle_questions ? questions.shuffle : questions
    end

    def evaluate_attempt(attempt)
      attempt.evaluate_attempt
    end
  end
end
