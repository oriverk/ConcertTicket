class AdminConcertsController < ApplicationController
  before_action :set_concert, only: %i[show edit update destroy]
  before_action :set_concert_detail, only: %i[show edit update destroy]
  # GET /concerts
  # GET /concerts.json
  def index
    @concerts = Concert.all.order(:date, :id)
  end

  # GET /concerts/1
  # GET /concerts/1.json
  def show; end

  # GET /concerts/new
  def new
    @concert = Concert.new
  end

  # GET /concerts/1/edit
  def edit; end

  # POST /concerts
  # POST /concerts.json
  def create
    @concert = Concert.new(concert_params)
    respond_to do |format|
      if @concert.save
        format.html { redirect_to @concert, notice: '新規作成しました' }
        format.json { render :show, status: :created, location: @concert }
      else
        format.html { render :new }
        format.json { render json: @concert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /concerts/1
  # PATCH/PUT /concerts/1.json
  def update
    respond_to do |format|
      if @concert.update(concert_params)
        format.html { redirect_to @concert, notice: '更新しました' }
        format.json { render :show, status: :ok, location: @concert }
      else
        format.html { render :edit }
        format.json { render json: @concert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /concerts/1
  # DELETE /concerts/1.json
  def destroy
    @concert.destroy
    respond_to do |format|
      format.html { redirect_to concerts_url, notice: 'Concert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_concert
    @concert = Concert.find(params[:id])
  end

  def set_concert_detail
    @concert_details = ConcertDetail.where(concert: params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def concert_params
    params.fetch(:concert, {})
  end
end
