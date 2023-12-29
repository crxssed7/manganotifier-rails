Rails.application.routes.draw do
  devise_for :users

  resources :mangas, only: [:index, :show, :destroy, :new, :create] do
    get :image, on: :member

    post :refresh, on: :member
    post :refresh_all, on: :collection
  end

  resources :notifiers

  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  root "mangas#index"
end
