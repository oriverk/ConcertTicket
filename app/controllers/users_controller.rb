# frozen_string_literal: true

require 'active_support/all'
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show history bill confirm edit update destroy]

  # def index
  # end

  def show
  end

  def history
    @sales = Sale.where(user_id: current_user.id).order(payment_deadline: :desc)
  end

  # history show
  def bill
    @sale = Sale.find(params[:sale])
    @concert = Concert.find(params[:concert])
  end

  def edit; end

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
      format.html { redirect_to users_url, notice: '退会手続きが完了しました。' }
      format.json { head :no_content }
    end
  end

  # confirm = new
  def confirm
    @payment = Payment.new
    @sale = Sale.find(params[:sale])
    @concert = Concert.find(params[:concert])
  end

  # 　ただし、paramの中は空なので、hiddenで異常系用に持ってくる
  def payment
    @user = User.find(current_user.id)
    @sale = Sale.find(params[:sale_id])
    @concert = Concert.find(params[:concert_id])
    @payment = Payment.new(sale_id: @sale.id, date: Date.current)
    respond_to do |format|
      if current_user.point < params_used_point
        format.html { render :confirm, notice: '所持ポイントを越えてポイントを使用しようとしました。' }
      else
        begin
          ActiveRecord::Base.transaction do
            if @sale.amount <= params_used_point
              @sale.update!(used_point: @sale.amount)
              @payment.update(amount: 0, added_point: 0)
            else
              @sale.update!(used_point: params_used_point)
              @payment.update!(amount: pay_amount, added_point: add_point.floor)
            end
            @user.update!(point: user_point)
            format.html { redirect_to user_history_path, notice: '支払が完了しました。' }
          end
        rescue StandardError => e
          logger.error e
          logger.error e.backtrace.join("\n")
          @sale = Sale.find(params[:sale_id])
          @concert = Concert.find(params[:concert_id])
          format.html { render :confirm, notice: '決済エラーが起きました。' }
        end
      end
    end
end

  private

  # Use callbacks to share common setup or constraints between actions.
  # Never trust parameters from the scary internet, only allow the white list through.
  def set_user
    @user = User.find(current_user.id)
  end
  
  def user_params
    params.require(:user).permit(:name, :email)
  end

  def sale_params
    params.require(:sale_id)
  end

  def params_used_point
    params[:used_point].to_i
  end

  def pay_amount
    @sale.amount - params_used_point
  end

  def add_point
    if pay_amount >= 20_000
      pay_amount * 0.03
    elsif pay_amount >= 10_000
      pay_amount * 0.02
    else
      pay_amount * 0.01
    end
  end

  def user_point
    @user.point - @sale.used_point + @payment.added_point
  end
end
