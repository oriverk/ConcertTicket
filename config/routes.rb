# frozen_string_literal: true

Rails.application.routes.draw do
  get '/' => 'static_pages#top'
  get 'privacy' => 'static_pages#privacy'
  devise_for :users  
  resources :concerts, only: [:index, :show]

  resources :users ,only:[:show, :edit, :update] do 
    get '/history' => 'users#history'
    get '/bill' => 'users#bill'
    get '/confirm' => 'users#confirm'
    post '/confirm' => 'users#payment'
  end
  
  resources :sales, only: [:new, :create]

  resources :admins
  resources :admin_users do
    member do
      get 'detail'
    end
  end
  resources :admin_concerts
end
