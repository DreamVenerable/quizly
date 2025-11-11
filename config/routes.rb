# frozen_string_literal: true

Quizly::Engine.routes.draw do
  resources :quizzes do
    resources :questions, shallow: true do
      resources :choices, shallow: true
    end
    resources :attempts, only: %i[new create show]
  end
end
