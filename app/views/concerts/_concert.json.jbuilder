# frozen_string_literal: true

json.extract! concert, :id, :infomation, :date, :created_at, :updated_at
json.url concert_url(concert, format: :json)
