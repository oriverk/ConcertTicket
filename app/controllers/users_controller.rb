# frozen_string_literal: true

require 'active_support/all'
class UsersController < ApplicationController
    before_action :authenticate_user!

  def index
    @sales = Sale.where(user_id: current_user.id)
  end

  def show;end

  def edit;
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
    @payment = Payment.new
    @sale = Sale.find(params[:sale_id])
    @concert = Concert.find(params[:concert_id])
  end
# transactionの前にbegin rescure
# なぜused_pointをオブジェクトに保存したのか、フォームからとって来いよ
# elseの後に@concert = Concert.find等をして、それからrender
#　ただし、paramの中は空なので、hiddenで異常系用に持ってくる

  # payment = create
  def payment
      @sale = Sale.find(sale_params)
      #@sale.used_point = params['used_point'].to_i
      @sale.save!
      # 決済額
      @pay_amount = @sale.amount - @sale.used_point
      @payment = Payment.new(sale_id: @sale.id , date: Date.current, amount: @pay_amount, added_point: add_point.floor)

      respond_to do |format|
        if @sale.used_point > current_user.point
          format.html { render :new}
          @sale = Sale.find(params[:sale_id])
          @concert = Concert.find(params[:concert_id])
        elsif  @payment.save!
          current_user.point = current_user.point - @sale.used_point + @payment.added_point
          current_user.save!
          # この中にsave全部突っ込めばいいんじゃね？
          format.html { redirect_to controller:'users',action:'index', notice: "支払いが完了しました。" }
          format.json { render :index, status: :created, location: @payment }
        else
          format.html { redirect_to controller:'users',action:'index', notice: "保存失敗。" }
          format.json { render :index, status: :created, location: @payment }
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

  def add_point
    if @pay_amount >= 20000
      return @pay_amount * 0.03
    elsif @pay_amount >= 10000
      return @pay_amount * 0.02
    else 
      return @pay_amount * 0.01
    end
  end
end
