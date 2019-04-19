# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :concert
  belongs_to :user
  has_one :payment

  validates :number_of_seats, presence: true
  validates :number_of_seats, numericality: { less_than_or_equal_to: 4 }
end
