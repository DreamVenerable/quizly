# frozen_string_literal: true

module Quizly
  class QuestionsController < ApplicationController
    before_action :set_quiz
    before_action :set_question, only: %i[show edit update destroy]

    def index
      @questions = @quiz.questions
    end

    def show; end

    def new
      @question = @quiz.questions.new
    end

    def create
      @question = @quiz.questions.new(question_params)

      if @question.save
        redirect_to quiz_question_path(@quiz, @question), notice: I18n.t("quizly.messages.question_created")
      else
        render :new
      end
    end

    def edit; end

    def update
      if @question.update(question_params)
        redirect_to quiz_question_path(@quiz, @question), notice: I18n.t("quizly.messages.question_updated")
      else
        render :edit
      end
    end

    def destroy
      @question.destroy
      redirect_to quiz_questions_url(@quiz), notice: I18n.t("quizly.messages.question_destroyed")
    end

    private

    def set_quiz
      @quiz = Quiz.find(params[:quiz_id])
    end

    def set_question
      @question = @quiz.questions.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:content)
    end
  end
end
