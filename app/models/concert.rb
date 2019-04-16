# frozen_string_literal: true

class Concert < ApplicationRecord
  has_many :concert_detail, dependent: :destroy
  has_many :sale
end
