# frozen_string_literal: true

class ConcertDetailsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_concert_detail, only: %i[show edit update destroy]

  # GET /concert_details
  # GET /concert_details.json
  def index
    @concert_details = ConcertDetail.all
    @sold_sest = 
  end

  # GET /concert_details/1
  # GET /concert_details/1.json
  def show; end

  # GET /concert_details/new
  def new
    @concert_detail = ConcertDetail.new
  end

  # GET /concert_details/1/edit
  def edit; end

  # POST /concert_details
  # POST /concert_details.json
  def create
    @concert_detail = ConcertDetail.new(concert_detail_params)

    respond_to do |format|
      if @concert_detail.save
        format.html { redirect_to @concert_detail, notice: '新規作成しました。' }
        format.json { render :show, status: :created, location: @concert_detail }
      else
        format.html { render :new }
        format.json { render json: @concert_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /concert_details/1
  # PATCH/PUT /concert_details/1.json
  def update
    respond_to do |format|
      if @concert_detail.update(concert_detail_params)
        format.html { redirect_to @concert_detail, notice: '更新しました。' }
        format.json { render :show, status: :ok, location: @concert_detail }
      else
        format.html { render :edit }
        format.json { render json: @concert_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /concert_details/1
  # DELETE /concert_details/1.json
  def destroy
    @concert_detail.destroy
    respond_to do |format|
      format.html { redirect_to concert_details_url, notice: 'Concert detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_concert_detail
    @concert_detail = ConcertDetail.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def concert_detail_params
    params.require(:concert_detail).permit(:concert_id, :grade, :price, :capacity)
  end
end
