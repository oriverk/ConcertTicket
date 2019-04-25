# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'concerts#index'
  resources :concerts
  get '/users/payment' ,to: 'users#payment'
  post 'users/payment' ,to: 'users#pay'
  patch 'users/payment', to: 'users#update'
  resources :users
  
  resources :concert_details
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :admins
  resources :sales
  
end
