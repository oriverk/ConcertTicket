require 'active_support/all'

class SalesController < ApplicationController
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
    @amount = @concert_detail.price * params["sale"]["number_of_seats"].to_i
    
    @sale = Sale.new(concert_id:@concert.id, user_id:current_user.id, grade:@concert_detail.grade , number_of_seats:params["sale"]["number_of_seats"].to_i, date:Date.current, amount:@amount , payment_deadline:Date.current+7.day)

    respond_to do |format|
      if @sale.save!
        format.html { redirect_to @sale, notice: '申込申請されました' }
        format.json { render :index, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def concert_params
     params.require(:sale)["concert_id"]
    end

    def concert_detail_params
      params.require(:sale)["concert_detail_id"]
    end
end

# Parameters: {"utf8"=>"✓", "authenticity_token"=>"wa2iEFUFSsCQ9ZImeiyPO+kbBJ9AIs63//OBPXxBkjKR/vMJ0rf7EHW2/GeAh65eJXTl0SnJmLyK0CFxiWrfcQ==", "sale"=>{"concert_id"=>"12", "concert_detail_id"=>"34","number_of_seats"=>"1"}, "commit"=>"Create Sale"}

# 使用ポイント@sale.used_point <= @user.point
# P使用前支払額amount　= @concert_detail.price * @sale.number_of_seats
# P使用後支払額amount_after_point = P仕様前支払額 - @sale.used_point
# 総請求額= 使用ポイント　なら　支払われたとして、決済表にレコード追加
# 追加ポイント　バッチ処理時の前日に決済処理された販売ID毎の決済額毎に付与
# add 3%point if @payment.amount >= 20000yen
# add 2%point if @payment.amount < 20000 && >= 10000
# add 1%point if @payment.amount < 10000
# SQL
# update 決済表 set add_point = (
# case when 決済額 >= 20000 thn floor (決済額 * 0.03)
# when 決済額 >=10000 then floor (決済額 * 0.02)
# else floor(決済額 * 0.01) end )
# where datediff(now(), 決済日) =1 