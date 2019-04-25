# frozen_string_literal: true

class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show destroy]

  def index
    @users = User.all
  end

  def show; end

  def new; end

  def edit; end

  def create; end

  def update; end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: '会員を削除しました' }
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
    params.require(:admin).permit(:name, :email)
  end
end
