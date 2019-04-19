class SalesController < ApplicationController
    before_action :set_sale, only: %i[show edit update destroy]
    before_action :set_concert, only: %i[show edit update destroy]
    before_action :set_detail, only: %i[show edit update destroy]


  def new
    @sale = Sale.new
    @concert = Concert.find(params[:concert_id])
    @concert_detail = ConcertDetail.find(params[:concert_detail_id])
  end

 
  def create
   @sale = Sale.new

   respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: '申込申請されました' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  
  private

  def set_sale
    @sale = Sale.find(params[:id])
  end

  def set_concert
    @concert = Concert.find(params[:id])
  end

  def set_detail
    @detail = ConcertDetail.find(params[:id])
  end
  
  def concert_params
    params.require(:id).permit(:infomation, :date)
  end

  def sale_params
    params.require(:id).permit(:concert_id, :user_id, :grade, :numbert_of_seats, :date, :amount, :paymment_deadline, :used_point)
  end
end
