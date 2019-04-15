# frozen_string_literal: true

json.extract! concert_detail, :id, :concert_id, :grade, :price, :capacity, :created_at, :updated_at
json.url concert_detail_url(concert_detail, format: :json)
