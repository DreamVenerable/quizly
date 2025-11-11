# frozen_string_literal: true

require "spec_helper"

RSpec.describe Quizly::Choice, type: :model do
  let(:quiz) { Quizly::Quiz.create!(title: "Quiz") }
  let(:question) { quiz.questions.create!(content: "Q") }

  it "is valid with content and question" do
    expect(Quizly::Choice.new(content: "A", question: question)).to be_valid
  end

  it "defaults is_correct to false" do
    choice = Quizly::Choice.create!(content: "A", question: question)
    expect(choice.is_correct).to eq(false)
  end
end
