# Quizly

Quizly is a mountable Rails engine that provides a simple framework for creating and managing quizzes. It ships models, controllers, migrations, I18n locales, and rake tasks for importing/exporting quiz data.

## Installation

Add the gem to your app:

```ruby
gem "quizly"
```

Run the installer to copy migrations and locales into your app:

```bash
rails generate quizly:install
rails db:migrate
```

Mount the engine in your app routes (e.g., at `/quizly`):

```ruby
# config/routes.rb (host app)
mount Quizly::Engine => "/quizly"
```

## Configuration

An initializer is created at `config/initializers/quizly.rb` with sensible defaults:

```ruby
Quizly.configure do |config|
  # Default locale for I18n messages
  # config.default_locale = :en

  # Shuffle questions and choices when presenting quizzes
  # config.shuffle_questions = true
  # config.shuffle_choices = true
end
```

## Models

- `Quizly::Quiz` — has many `questions`, has many `attempts`, requires a `title`.
- `Quizly::Question` — belongs to `quiz`, has many `choices`, requires `content`.
- `Quizly::Choice` — belongs to `question`, `is_correct` boolean (default `false`).
- `Quizly::Attempt` — belongs to `quiz`, has many `attempt_answers`; computes `score` and `percentage`.
- `Quizly::AttemptAnswer` — belongs to `attempt`, `question`, optional `choice`; unique per `[attempt, question]`.

Tables use the `quizly_` prefix (e.g., `quizly_quizzes`, `quizly_questions`), handled automatically by the engine.

## Usage Example

Programmatically create a quiz with questions and choices:

```ruby
quiz = Quizly::Quiz.create!(title: "Sample Quiz")
q1 = quiz.questions.create!(content: "2 + 2 = ?")
q1.choices.create!(content: "3", is_correct: false)
q1.choices.create!(content: "4", is_correct: true)

# Record an attempt
attempt = Quizly::Attempt.create!(quiz: quiz)
answer = Quizly::AttemptAnswer.create!(attempt: attempt, question: q1, choice: q1.correct_choice)

# Evaluate
attempt.evaluate_attempt
attempt.score      #=> 1
attempt.percentage #=> 100.0
```

## Controllers & Routes

The engine exposes RESTful controllers under the `Quizly` namespace:

- `QuizzesController` — CRUD for quizzes.
- `QuestionsController` — nested under quizzes.
- `ChoicesController` — nested under questions.
- `AttemptsController` — start and show attempts.

See `config/routes.rb` inside the gem for the full resource graph.

## Import/Export Tasks

The gem includes rake tasks for data management in a host app:

- Import from YAML/JSON: `rake quizly:import[FILE_PATH]`
- Export to YAML/JSON: `rake quizly:export[FILE_PATH,FORMAT]` (format: `yaml` or `json`)

## Testing

Run the test suite:

```bash
bundle exec rspec
```

Specs use in-memory SQLite and run the engine’s migrations automatically; no external setup required.

## Development

- Install dependencies: `bin/setup`
- Run tests: `bundle exec rspec` or `rake spec`
- Lint: `bundle exec rubocop`

To install the gem locally:

```bash
bundle exec rake install
```

To release a new version:

1. Update `lib/quizly/version.rb`.
2. Ensure `CHANGELOG.md` reflects changes.
3. Run `bundle exec rake release` (tags, builds, and pushes the gem).

## Contributing

Bug reports and pull requests are welcome on GitHub. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](./CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
