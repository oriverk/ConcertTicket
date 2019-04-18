# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.admin?
      @users = User.all
    else
      @user = User.find(current_user.id)
      # @payment = Payment.find(current_user.id)
    end
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

  private
    
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
