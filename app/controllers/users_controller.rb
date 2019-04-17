# frozen_string_literal: true

class UsersController < ApplicationController

  def index
    if current_user.admin?
      @users = User.all
    else
      @user = User.find(current_user.id)
      # @payment = Payment.find(current_user.id)
    end
  end

  def create
    if @user.save
      NotificationMailer.send_confirm_to_user(@user).deliver
      redirect_to @user
    else
      render 'new'
    end
  end
end
