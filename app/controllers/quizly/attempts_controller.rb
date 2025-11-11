# frozen_string_literal: true

module Quizly
  class AttemptsController < ApplicationController
    before_action :set_quiz, only: %i[new create]
    before_action :set_attempt, only: [:show]

    def new
      @attempt = @quiz.attempts.new
      # For now, we'll assume a user is available via `current_user` or similar.
      # In a real app, you'd associate attempts with a logged-in user.
      @attempt.user = current_user if defined?(current_user)
      @questions = @quiz.shuffled_questions
    end

    def create
      @attempt = @quiz.attempts.new(attempt_params)
      @attempt.user = current_user if defined?(current_user)

      if @attempt.save
        # Process the answers given by the user.
        # This would typically involve iterating through params[:attempt][:answers]
        # and creating AttemptAnswer records.

        params[:attempt_answers].each do |question_id, choice_id|
          @attempt.attempt_answers.create(
            question_id: question_id,
            choice_id: choice_id
          )
        end

        @attempt.evaluate_attempt # This method needs to be implemented in the Attempt model
        @attempt.save # Save score and percentage

        redirect_to quiz_attempt_path(@quiz, @attempt), notice: I18n.t("quizly.messages.attempt_recorded")
      else
        @questions = @quiz.shuffled_questions # Re-render new form with errors
        render :new
      end
    end

    def show
      @quiz = @attempt.quiz
      @attempt_answers = @attempt.attempt_answers.includes(:question, :choice)
    end

    private

    def set_quiz
      @quiz = Quiz.find(params[:quiz_id])
    end

    def set_attempt
      @attempt = Attempt.find(params[:id])
    end

    def attempt_params
      # Permit only the necessary parameters. User_id is set separately.
      params.fetch(:attempt, {}).permit
    end
  end
end
