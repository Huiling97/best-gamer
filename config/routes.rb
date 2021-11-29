Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'coaches', to: 'users#filter_by_game'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
