# frozen_string_literal: true

class CreateQuizlyQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :quizly_questions do |t|
      t.references :quiz, null: false, foreign_key: { to_table: :quizly_quizzes }
      t.text :content, null: false

      t.timestamps
    end
  end
end
