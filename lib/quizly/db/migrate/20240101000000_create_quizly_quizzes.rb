# frozen_string_literal: true

class CreateQuizlyQuizzes < ActiveRecord::Migration[8.0]
  def change
    create_table :quizly_quizzes do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
