Rails.application.routes.draw do
  resources :mangas, only: [:index, :show, :destroy, :new, :create] do
    post :refresh, on: :member
    post :refresh_all, on: :collection
  end

  resources :notifiers

  root "mangas#index"
end
