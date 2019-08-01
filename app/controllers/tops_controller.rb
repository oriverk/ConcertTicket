# frozen_string_literal: true

class TopsController < ApplicationController
  def top
    @concert = Concert.first
  end
end
