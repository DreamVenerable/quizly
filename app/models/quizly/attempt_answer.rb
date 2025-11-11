# frozen_string_literal: true

module Quizly
  class AttemptAnswer < ApplicationRecord
    belongs_to :attempt
    belongs_to :question
    belongs_to :choice, optional: true # The choice selected by the user, can be nil if no choice was made

    validates :question_id, uniqueness: { scope: :attempt_id, message: "should be unique per attempt" }
  end
end
