# frozen_string_literal: true

require "yaml"
require "json"

module Quizly
  class Exporter
    def initialize(file_path, format = "yaml")
      @file_path = file_path
      @format = format
    end

    def export!
      validate_file!
      data = collect_data
      content = serialize(data)
      File.write(@file_path, content)
      puts "✅ Exported quizzes to #{@file_path} (#{@format} format)"
    rescue StandardError => e
      puts "❌ Error exporting quizzes: #{e.message}"
    end

    private

    def validate_file!
      raise "File path not provided." unless @file_path
    end

    def collect_data
      Quizly::Quiz.includes(questions: :choices).map do |quiz|
        {
          "title" => quiz.title,
          "questions" => quiz.questions.map do |q|
            {
              "content" => q.content,
              "choices" => q.choices.map do |c|
                {
                  "content" => c.content,
                  "is_correct" => c.is_correct
                }
              end
            }
          end
        }
      end
    end

    def serialize(data)
      case @format
      when "json" then JSON.pretty_generate(data)
      else data.to_yaml
      end
    end
  end
end
