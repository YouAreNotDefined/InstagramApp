Rails.application.routes.draw do
  namespace :api, { format: 'json' } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
          registrations: 'api/v1/auth/registrations'
      }

      resources :posts, only: [:create, :show, :destroy]
      resources :hashtags, only: [:index, :show]
      resources :comments, only: [:create, :show, :destroy]
      resources :likes, only: [:create]
      resources :users, only: [:index, :profile, :follow] do
        collection do
          get 'profile'
        end
        member do
          put 'follow'
        end
      end
      resources :genders, only: [:index]
    end
  end
end
