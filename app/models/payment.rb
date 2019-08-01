# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :sale
  validates :amount, numericality: {greater_than_or_equal_to: 0}
  validates :added_point, numericality: { greater_than_or_equal_to: 0}
end
