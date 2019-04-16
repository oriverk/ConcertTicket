# frozen_string_literal: true

Rails.application.routes.draw do
  resources :concert_details
  resources :concerts
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :admins
  resources :users
end
