Rails.application.routes.draw do
  resources :mangas, only: [:index, :show, :destroy, :new, :create] do
    post :refresh, on: :member
    post :refresh_all, on: :collection
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "mangas#index"
end
