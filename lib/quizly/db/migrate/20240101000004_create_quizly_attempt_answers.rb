# frozen_string_literal: true

class CreateQuizlyAttemptAnswers < ActiveRecord::Migration[8.0]
  def change
    create_table :quizly_attempt_answers do |t|
      t.references :attempt, null: false, foreign_key: { to_table: :quizly_attempts }
      t.references :question, null: false, foreign_key: { to_table: :quizly_questions }
      t.references :choice, foreign_key: { to_table: :quizly_choices }

      t.timestamps
    end

    add_index :quizly_attempt_answers, %i[attempt_id question_id], unique: true,
                                                                   name: "index_quizly_attempt_answers_on_attempt_and_question"
  end
end
