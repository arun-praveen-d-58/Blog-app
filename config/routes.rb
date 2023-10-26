Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # devise_for :users

  # devise_scope :user do
  #  get '/users/sign_out' => 'devise/sessions#destroy'
  # end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "topics#index"
  resources :topics do
    resources :posts do
      member do
        delete :purge_image
      end
      resources :comments do
        resources :user_comment_ratings, only: %i[create index update]
      end
      resources :ratings
    end
  end
  resources :posts do
    member do
      delete :purge_image
    end
    resources :comments do
      resources :user_comment_ratings, only: %i[create index update]
    end
    resources :ratings
    post 'mark_as_read', to: 'posts#mark_as_read', as: 'mark_as_read'

  end
  resources :tags


end
