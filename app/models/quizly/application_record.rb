# frozen_string_literal: true

module Quizly
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
