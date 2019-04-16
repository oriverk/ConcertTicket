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
end
