Rails.application.routes.draw do
  devise_for :users

  resources :mangas do
    get :image, on: :member

    post :refresh, on: :member
    post :refresh_all, on: :collection
  end

  resources :notifiers

  resources :discord_users, only: [:index]

  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  root "mangas#index"
end
