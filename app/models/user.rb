# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sale

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, presence: { case_sensitive: false }
end
