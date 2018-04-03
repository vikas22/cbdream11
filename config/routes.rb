Rails.application.routes.draw do
  resources :players
  resources :teams
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  get '/scrap/:tourId/:matchId', to: 'application#scrap'
  get '/players/user/:userId', to: 'players#user'
  get '/players/user/:playerId/:userId', to: 'players#update_user'

end
