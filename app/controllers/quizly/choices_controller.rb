# frozen_string_literal: true

module Quizly
  class ChoicesController < ApplicationController
    before_action :set_question
    before_action :set_choice, only: %i[show edit update destroy]

    def index
      @choices = @question.choices
    end

    def show; end

    def new
      @choice = @question.choices.new
    end

    def create
      @choice = @question.choices.new(choice_params)

      if @choice.save
        redirect_to quiz_question_choice_path(@question.quiz, @question, @choice),
                    notice: I18n.t("quizly.messages.choice_created")
      else
        render :new
      end
    end

    def edit; end

    def update
      if @choice.update(choice_params)
        redirect_to quiz_question_choice_path(@question.quiz, @question, @choice),
                    notice: I18n.t("quizly.messages.choice_updated")
      else
        render :edit
      end
    end

    def destroy
      @choice.destroy
      redirect_to quiz_question_choices_url(@question.quiz, @question),
                  notice: I18n.t("quizly.messages.choice_destroyed")
    end

    private

    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_choice
      @choice = @question.choices.find(params[:id])
    end

    def choice_params
      params.require(:choice).permit(:content, :is_correct)
    end
  end
end
