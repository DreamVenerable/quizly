# frozen_string_literal: true

require "spec_helper"

RSpec.describe Quizly::Attempt, type: :model do
  let(:quiz) { Quizly::Quiz.create!(title: "Math") }

  def add_question_with_choices(content:, correct: "A")
    q = quiz.questions.create!(content: content)
    a = q.choices.create!(content: "A", is_correct: correct == "A")
    b = q.choices.create!(content: "B", is_correct: correct == "B")
    [q, a, b]
  end

  it "computes score and percentage" do
    q1, a1, = add_question_with_choices(content: "Q1", correct: "A")
    q2, a2, = add_question_with_choices(content: "Q2", correct: "B")

    attempt = Quizly::Attempt.create!(quiz: quiz)
    # Answer first correctly, second incorrectly
    Quizly::AttemptAnswer.create!(attempt: attempt, question: q1, choice: a1)
    Quizly::AttemptAnswer.create!(attempt: attempt, question: q2, choice: a2) # wrong

    expect(attempt.score).to eq(1)
    expect(attempt.percentage.round(2)).to eq(50.0)

    attempt.evaluate_attempt
    expect(attempt.score).to eq(1)
    expect(attempt.percentage.round(2)).to eq(50.0)
  end
end
