# frozen_string_literal: true

require 'active_support/all'

class SalesController < ApplicationController
  before_action :authenticate_user!

  def index
    @sale = Sale.all
  end

  def new
    @sale = Sale.new
    @concert = Concert.find(params[:concert_id])
    @concert_detail = ConcertDetail.find(params[:concert_detail_id])
  end

  def create
    @concert = Concert.find(concert_params)
    @concert_detail = ConcertDetail.find(concert_detail_params)
    @amount = @concert_detail.price * params['sale']['number_of_seats'].to_i

    @sale = Sale.new(concert_id: @concert.id, user_id: current_user.id, grade: @concert_detail.grade, number_of_seats: params['sale']['number_of_seats'], date: Date.current, amount: @amount, payment_deadline: Date.current + 7.days)

    respond_to do |format|
      if @sale.save!
        format.html { redirect_to controller: 'users', action: 'index', notice: '申込申請されました' }
        format.json { render :index, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def concert_params
    params.require(:sale)['concert_id']
  end

  def concert_detail_params
    params.require(:sale)['concert_detail_id']
  end
end
