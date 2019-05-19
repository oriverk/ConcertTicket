class TopsController < ApplicationController

  def top
    @concert = Concert.first
  end 
end
