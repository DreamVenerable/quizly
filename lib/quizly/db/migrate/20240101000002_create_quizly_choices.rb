# frozen_string_literal: true

class CreateQuizlyChoices < ActiveRecord::Migration[8.0]
  def change
    create_table :quizly_choices do |t|
      t.references :question, null: false, foreign_key: { to_table: :quizly_questions }
      t.text :content, null: false
      t.boolean :is_correct, null: false, default: false

      t.timestamps
    end
  end
end
