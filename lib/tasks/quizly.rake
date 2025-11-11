# frozen_string_literal: true

require "rake"
require "yaml"
require "json"

namespace :quizly do
  desc "Copies Quizly migrations to the host application"
  task "install:migrations" do
    Rake::Task["railties:install:migrations"].invoke("quizly")
  end
  desc "Import quizzes from a YAML or JSON file"
  task :import, [:file] => :environment do |t, args|
    file_path = args[:file]
    unless file_path
      puts "Usage: rake quizly:import[file_path]"
      exit 1
    end

    unless File.exist?(file_path)
      puts "Error: File '#{file_path}' not found."
      exit 1
    end

    content = File.read(file_path)
    data = if file_path.end_with?(".json")
             JSON.parse(content)
           elsif file_path.end_with?(".yml", ".yaml")
             YAML.safe_load(content)
           else
             puts "Error: Unsupported file format. Please use .yml, .yaml, or .json."
             exit 1
           end

    data.each do |quiz_data|
      quiz = Quizly::Quiz.create!(title: quiz_data["title"])
      quiz_data["questions"].each do |question_data|
        question = quiz.questions.create!(content: question_data["content"])
        question_data["choices"].each do |choice_data|
          question.choices.create!(content: choice_data["content"], is_correct: choice_data["is_correct"])
        end
      end
      puts "Imported quiz: #{quiz.title}"
    rescue StandardError => e
      puts "Error importing quiz: #{e.message}"
    end
    puts "Quiz import complete."
  end

  desc "Export quizzes to a YAML or JSON file"
  task :export, %i[file format] => :environment do |t, args|
    file_path = args[:file]
    format = args[:format] || "yaml"

    unless file_path
      puts "Usage: rake quizly:export[file_path,format] (format can be yaml or json, default is yaml)"
      exit 1
    end

    quizzes_data = Quizly::Quiz.all.map do |quiz|
      {
        "title" => quiz.title,
        "questions" => quiz.questions.map do |question|
          {
            "content" => question.content,
            "choices" => question.choices.map do |choice|
              {
                "content" => choice.content,
                "is_correct" => choice.is_correct?
              }
            end
          }
        end
      }
    end

    output_content = if format == "json"
                       JSON.pretty_generate(quizzes_data)
                     else # default to yaml
                       quizzes_data.to_yaml
                     end

    File.write(file_path, output_content)
    puts "Quizzes exported to #{file_path} in #{format} format."
  rescue StandardError => e
    puts "Error exporting quizzes: #{e.message}"
  end
end
