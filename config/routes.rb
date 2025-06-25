Rails.application.routes.draw do
  root 'teams#index'

  resources :teams do
    resources :players, except: [:index]
  end

  # Routes globales pour les joueurs
  resources :players, only: [:index, :new, :create]

  # Routes des tournois
  resources :tournaments, only: [:index, :show]
  post 'tournaments/auto', to: 'tournaments#generate_auto', as: 'generate_auto_tournament'
  post 'tournaments/faker', to: 'tournaments#generate_faker', as: 'generate_faker_tournament'
end
