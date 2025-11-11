# frozen_string_literal: true

# Use this hook to configure Quizly
Quizly.configure do |config|
  # === Locale Configuration ===
  # The default locale for Quizly. This locale will be used for displaying
  # messages and content if no other locale is specified or available.
  # Default: :en
  # config.default_locale = :en

  # === Quiz Behavior ===
  # Whether to shuffle the order of questions when a quiz is presented.
  # Set to true for a randomized question order, false to maintain creation order.
  # Default: true
  # config.shuffle_questions = true

  # Whether to shuffle the order of choices for each question.
  # Set to true for randomized choice order, false to maintain creation order.
  # Default: true
  # config.shuffle_choices = true
end
