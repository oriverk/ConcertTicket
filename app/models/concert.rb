# frozen_string_literal: true

class Concert < ApplicationRecord
  has_many :concert_detail
  has_many :sale
end
