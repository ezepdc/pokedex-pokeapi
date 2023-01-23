Rails.application.routes.draw do
  resources :pokemons, only: [:index, :show]
  root to: "pokemons#index"
end
