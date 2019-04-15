# frozen_string_literal: true

json.array! @concert_details, partial: 'concert_details/concert_detail', as: :concert_detail
