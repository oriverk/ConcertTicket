# frozen_string_literal: true

require 'active_support/all'
class UsersController < ApplicationController

  def index
    @sales = Sale.where(user_id: current_user.id)
  end

  def show
  end

  def edit

  end

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
    @concert = Concert.find(params[:concert_id])
    @sale = Sale.find(params[:sale_id])
    @payment = Payment.new
    logger.debug "1--------payment"
  end

  # payment = create
  def payment
    @sale = Sale.find(params[:sale_id])
    @sale.used_point = params['used_point'].to_i
    logger.debug "2----------pay"
    @sale.save

    amount = @sale.amount - @sale.used_point
    added_point = 0
    if amount >= 20000
      added_point = amount * 0.03
    elsif amount >= 10000
      added_point = amount * 0.02
    else added_point = amount * 0.01
    end

    @payment = Payment.new(sale_id: @sale.id , date: Date.current, amount: amount, added_point: added_point.floor)
    current_user.point = current_user.point + added_point - @sale.used_point
    current_user.save

    respond_to do |format|
      if @payment.save!
        format.html { redirect_to controller:'users',action:'index', notice: "支払いが完了しました。" }
        format.json { render :index, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
