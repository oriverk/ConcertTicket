# frozen_string_literal: true

Rails.application.routes.draw do
  get '/' => 'static_pages#top'
  get 'privacy' => 'static_pages#privacy'
  devise_for :users
  resources :concerts
  
 resources :users do
  get '/history' => 'users#history'
  get '/bill' => 'users#bill'
  get '/confirm', to: 'users#confirm'
  post '/confirm', to: 'users#payment'
 end
  resources :concert_details
  resources :sales

  resources :admins, only: [:index]
  resources :admin_users do
    member do
      get 'detail' 
    end
  end


  
  resources :admin_concerts
end
