# frozen_string_literal: true

Rails.application.routes.draw do
  get '/' => 'static_pages#top'
  get 'privacy' => 'static_pages#privacy'
  devise_for :users
  resources :concerts
  resources :users
  get 'users/purchase' => 'users#purchase'
  get '/users/confirm', to: 'users#confirm'
  post 'users/confirm', to: 'users#payment'
 
  resources :concert_details
  resources :sales

  resources :admins
  namespace :admin do
    resources :users, only: [:index, :show, :destroy]
    resources :concerts
    resources :concert_details
    resources :sales
  end
end
