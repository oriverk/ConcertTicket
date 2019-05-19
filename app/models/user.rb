# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sale

  validates :email, presence: true, uniqueness: true
  validates :email, presence: { case_sensitive: false }
  validates :point, numericality: { greater_than_or_equal_to: 0}

  
end
