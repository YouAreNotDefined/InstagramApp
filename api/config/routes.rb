Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          registrations: 'api/v1/auth/registrations'
      }

      resources :posts, only: [:index, :new, :create, :show, :destroy]
      resources :comments, only: [:create, :show, :destroy]

      get 'user', to: 'users#show'
      get 'post/like', to: 'likes#save_like'
    end
  end
end
