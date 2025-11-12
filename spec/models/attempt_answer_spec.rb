# frozen_string_literal: true

require "spec_helper"

RSpec.describe Quizly::AttemptAnswer, type: :model do
  let(:quiz) { Quizly::Quiz.create!(title: "Science") }
  let(:question) { quiz.questions.create!(content: "Q1") }
  let(:choice) { question.choices.create!(content: "A", is_correct: true) }
  let(:attempt) { Quizly::Attempt.create!(quiz: quiz) }

  it "enforces uniqueness of question per attempt" do
    Quizly::AttemptAnswer.create!(attempt: attempt, question: question, choice: choice)
    dup = Quizly::AttemptAnswer.new(attempt: attempt, question: question, choice: choice)
    expect(dup).not_to be_valid
    expect(dup.errors[:question_id]).to be_present
  end
end
