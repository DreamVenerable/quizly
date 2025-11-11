# frozen_string_literal: true

require "spec_helper"

RSpec.describe Quizly::Question, type: :model do
  let(:quiz) { Quizly::Quiz.create!(title: "General Knowledge") }

  it "is valid with content and quiz" do
    expect(Quizly::Question.new(content: "What?", quiz: quiz)).to be_valid
  end

  it "is invalid without content" do
    expect(Quizly::Question.new(content: nil, quiz: quiz)).not_to be_valid
  end

  it "shuffles choices when configured" do
    Quizly.configure { |c| c.shuffle_choices = true }
    question = quiz.questions.create!(content: "Choose")
    c1 = question.choices.create!(content: "A", is_correct: false)
    c2 = question.choices.create!(content: "B", is_correct: true)
    shuffled = question.shuffled_choices
    expect(shuffled).to contain_exactly(c1, c2)
  end

  it "keeps choices order when shuffling disabled" do
    Quizly.configure { |c| c.shuffle_choices = false }
    question = quiz.questions.create!(content: "Order")
    c1 = question.choices.create!(content: "A", is_correct: false)
    c2 = question.choices.create!(content: "B", is_correct: true)
    expect(question.shuffled_choices.map(&:id)).to eq([c1.id, c2.id])
  end
end
