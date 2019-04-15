# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :concert
  belongs_to :user
  has_one :payment

  validates :seats_total, presence: true
  validates :seats_total, numericality: { less_than_or_equal_to: 4 }
end
