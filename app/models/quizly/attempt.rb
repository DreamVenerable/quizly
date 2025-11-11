# frozen_string_literal: true

module Quizly
  class Attempt < ApplicationRecord
    belongs_to :quiz
    # belongs_to :user # Assuming a user model will be present in the host app
    has_many :attempt_answers, dependent: :destroy # To be created later

    def score
      attempt_answers.includes(:question, :choice).count do |attempt_answer|
        attempt_answer.choice&.is_correct?
      end
    end

    def percentage
      total_questions = quiz.questions.count
      return 0.0 if total_questions.zero?

      (score.to_f / total_questions) * 100
    end

    def evaluate_attempt
      self.score = score
      self.percentage = percentage
      true # Or false if there's a reason for it to fail
    end
  end
end
