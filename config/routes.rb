Rails.application.routes.draw do
  resources :mangas, only: [:index, :show, :destroy, :new, :create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "mangas#index"
end
