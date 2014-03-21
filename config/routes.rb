Mamamia2::Application.routes.draw do
  resources :users, except: [:new, :edit, :destroy]
  post 'session' => 'session#create'
  get 'api_keys' => 'api_keys#show'
  match 'session', to: 'session#create', via: [:options]
  match 'users', to: 'users#index', via: [:options]
  root 'application#index'
end
