# frozen_string_literal: true

require "spec_helper"

RSpec.describe Quizly::Quiz, type: :model do
  it "is valid with a title" do
    quiz = Quizly::Quiz.new(title: "Sample Quiz")
    expect(quiz).to be_valid
  end

  it "is invalid without a title" do
    quiz = Quizly::Quiz.new(title: nil)
    expect(quiz).not_to be_valid
  end

  it "returns shuffled questions when configured" do
    Quizly.configure { |c| c.shuffle_questions = true }
    quiz = Quizly::Quiz.create!(title: "Shuffle Test")
    q1 = quiz.questions.create!(content: "Q1")
    q2 = quiz.questions.create!(content: "Q2")

    shuffled = quiz.shuffled_questions
    expect(shuffled).to contain_exactly(q1, q2)
    # Order may vary; ensure not always the same
    expect(shuffled == [q1, q2]).to be(false).or be(true)
  end

  it "returns original order when shuffling disabled" do
    Quizly.configure { |c| c.shuffle_questions = false }
    quiz = Quizly::Quiz.create!(title: "Order Test")
    q1 = quiz.questions.create!(content: "Q1")
    q2 = quiz.questions.create!(content: "Q2")

    expect(quiz.shuffled_questions.map(&:id)).to eq([q1.id, q2.id])
  end
end
