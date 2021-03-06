Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, only: [:create] do
    collection do
      get '/search/' => 'users#search', as: :search
    end
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

  constraints Clearance::Constraints::SignedIn.new do
    root to: 'posts#index', as: :signed_in_root
    resources :posts, only: [:index, :create]
    resources :notifications, only: [:index]
    scope '/:username' do
      put '/follow' => 'users#follow', as: :follow_user
      put '/unfollow' => 'users#unfollow', as: :unfollow_user
    end
  end

  scope '/:username' do
    get '/' => 'users#show', as: :user
    resources :posts, only: [:show]
    get '/following' => 'users#following', as: :following
    get '/followers' => 'users#followers', as: :followers
  end

  root to: 'home#index'
end
