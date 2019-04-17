# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'concerts#index'
  resources :concerts
  resources :users
  resources :concert_details
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :admins
end
