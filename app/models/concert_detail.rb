# frozen_string_literal: true

class ConcertDetail < ApplicationRecord
  belongs_to :concert
  enum grade: { S: 0, A: 1, B: 2 }
end
