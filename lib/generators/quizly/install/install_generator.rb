# frozen_string_literal: true

module Quizly
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      desc "Copies Quizly migrations, locale files, and creates an initializer."

      def copy_migrations
        rake "quizly:install:migrations"
      end

      def copy_locale_files
        copy_file "en.yml", "config/locales/quizly.en.yml"
        copy_file "ar.yml", "config/locales/quizly.ar.yml"
      end

      def create_initializer_file
        copy_file "initializer.rb", "config/initializers/quizly.rb"
      end

      def show_readme
        readme "README"
      end
    end
  end
end
