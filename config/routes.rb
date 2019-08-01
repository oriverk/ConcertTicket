# frozen_string_literal: true

Rails.application.routes.draw do
  get '/', to: 'tops#top'
  devise_for :users
  root 'concerts#index'
  resources :concerts
  get '/users/confirm', to: 'users#confirm'
  post 'users/confirm', to: 'users#payment'
  resources :users
  resources :concert_details
  resources :admins
  resources :sales
end
