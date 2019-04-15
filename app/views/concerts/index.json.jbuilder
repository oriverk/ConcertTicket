# frozen_string_literal: true

json.array! @concerts, partial: 'concerts/concert', as: :concert
