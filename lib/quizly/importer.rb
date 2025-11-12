# frozen_string_literal: true

require "yaml"
require "json"

module Quizly
  class Importer
    def initialize(file_path)
      @file_path = file_path
    end

    def import!
      validate_file!
      data = load_data
      import_quizzes(data)
      puts "✅ Quiz import complete."
    end

    private

    def validate_file!
      raise "File path not provided." unless @file_path
      raise "File '#{@file_path}' not found." unless File.exist?(@file_path)
    end

    def load_data
      content = File.read(@file_path)
      case File.extname(@file_path)
      when ".json" then JSON.parse(content)
      when ".yml", ".yaml" then YAML.safe_load(content)
      else raise "Unsupported format. Use .yml, .yaml, or .json."
      end
    end

    def import_quizzes(data)
      data.each do |quiz_data|
        quiz = Quizly::Quiz.create!(title: quiz_data["title"])
        quiz_data["questions"].each do |q|
          question = quiz.questions.create!(content: q["content"])
          q["choices"].each do |c|
            question.choices.create!(content: c["content"], is_correct: c["is_correct"])
          end
        end
        puts "Imported quiz: #{quiz.title}"
      end
    rescue StandardError => e
      puts "❌ Error importing quiz: #{e.message}"
    end
  end
end
