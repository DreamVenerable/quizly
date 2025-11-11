# frozen_string_literal: true

class CreateQuizlyAttempts < ActiveRecord::Migration[8.0]
  def change
    create_table :quizly_attempts do |t|
      t.references :quiz, null: false, foreign_key: { to_table: :quizly_quizzes }
      # Polymorphic associations cannot have a foreign_key constraint
      t.references :user, polymorphic: true, index: true
      t.integer :score
      t.float :percentage

      t.timestamps
    end
  end
end
