Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create, :destroy] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  
  
  resources :plans, only: [:create, :destroy, :show] do
    member do
      resources :details, only: [:new, :create]
      resources :details do
        get :show
        get :edit
        patch :update
        put :update
        delete :destroy
      end
    end
  end
  

  
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
end
