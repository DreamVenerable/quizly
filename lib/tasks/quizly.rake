# frozen_string_literal: true

require "rake"
require "yaml"
require "json"

namespace :quizly do
  desc "Import quizzes from a YAML or JSON file"
  task :import, [:file] => :environment do |_, args|
    require "quizly/importer"
    Quizly::Importer.new(args[:file]).import!
  end

  desc "Export quizzes to a YAML or JSON file"
  task :export, %i[file format] => :environment do |_, args|
    require "quizly/exporter"
    Quizly::Exporter.new(args[:file], args[:format]).export!
  end
end