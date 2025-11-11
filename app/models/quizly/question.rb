# frozen_string_literal: true

module Quizly
  class Question < ApplicationRecord
    belongs_to :quiz
    has_many :choices, dependent: :destroy

    validates :content, presence: true

    def shuffled_choices
      Quizly.configuration.shuffle_choices ? choices.shuffle : choices
    end

    def correct_choice
      choices.find_by(is_correct: true)
    end
  end
end
