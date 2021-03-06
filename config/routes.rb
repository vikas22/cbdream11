Rails.application.routes.draw do
  resources :player_scores
  resources :players
  resources :teams
  resources :users
  resources :leagues
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  get '/scrap/:tourId/:matchId', to: 'application#scrap'
  get '/score/:tourId/:matchId', to: 'application#scrapScoreCard'
  get '/leages/:leagueId/team', to: 'application#addPlayers'
  get '/players/user/:userId', to: 'players#user'
  get '/players/user/:playerId/:userId', to: 'players#update_user'
  get '/players/search/:name', to: 'players#search'
  get '/user/destroy/:id', to: 'application#destroyUser'

end
