# frozen_string_literal: true

require 'active_support/all'
class UsersController < ApplicationController
    before_action :authenticate_user!

  def index
    @sales = Sale.where(user_id: current_user.id)
    @payments = Payment.where(user_id: current_user.id)
  end

  def show;end

  def edit;end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        NotificationMailer.send_confirm_to_user(@user).deliver
        redirect_to @user
        format.html { redirect_to @user, notice: '登録情報が追加されました' }
        format.json { render :show, status: :created, location: @user }
      else
        render 'new'
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to action: :index, notice: '登録情報が更新されました' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: '登録情報は削除されました' }
      format.json { head :no_content }
    end
  end

  # confirm = new
  def confirm
    logger.debug "CONFIRM-----------------------------------------"
  logger.debug "Params is #{params}"
    @payment = Payment.new
    @sale = Sale.find(params[:sale_id])
    @concert = Concert.find(params[:concert_id])
  end
  # transactionの前にbegin rescure
  # なぜused_pointをオブジェクトに保存したのか、フォームからとって来いよ
  # elseの後に@concert = Concert.find等をして、それからrender
  #　ただし、paramの中は空なので、hiddenで異常系用に持ってくる

  def payment
    logger.debug "PAYMENT-----------------------------------------"
    logger.debug "Params is #{params}"
    @user = User.find(current_user.id)
    @sale = Sale.find(params[:sale_id])
    @concert = Concert.find(params[:concert_id])
    @payment = Payment.new(sale_id: @sale.id, date: Date.current)
    respond_to do |format|
      if current_user.point < params_used_point
        format.html {redirect_to controller:'users', action: 'index', notice:"所持P超過"}
      else
        begin
        #エラーとなりそうな箇所
          ActiveRecord::Base.transaction do
            logger.debug "Transaction do"
            if @sale.amount <= params_used_point
              logger.debug "!!!!!!!!!!!!!!!!!!!!!<="
              @sale.update!(used_point: @sale.amount)
              @payment.update(amount:0,added_point:0)
            else
              logger.debug "!!!!!!!!!!!!!!!!!!!!!!!!!>"     
              @sale.update!(used_point: params_used_point)
              @payment.update!(amount: pay_amount, added_point: add_point.floor)
            end
            @user.update!(point: user_point)
            format.html {redirect_to controller:'users', action: 'index', notice:"支払い完了"}
          end
        rescue => e
          logger.debug "RESCUE-----------------------------------------"
          puts e
          logger.error e
          logger.error e.backtrace.join("\n")
          @sale = Sale.find(params[:sale_id])
          @concert = Concert.find(params[:concert_id])
          format.html { render :confirm, notice: "エラー" }
          logger.debug "RESCUE did-----------------------------------------"
        end
      end
  end
end

private
  # Use callbacks to share common setup or constraints between actions.
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email)
  end

  def sale_params
    params.require(:sale_id)
  end

  def params_used_point
    return params[:used_point].to_i
  end

  def pay_amount
    return @sale.amount - params_used_point
  end

  def add_point
    if pay_amount >= 20000
      return pay_amount * 0.03
    elsif pay_amount >= 10000
      return pay_amount * 0.02
    else 
      return pay_amount * 0.01
    end
  end

  def user_point
    return @user.point - @sale.used_point + @payment.added_point
  end
end

