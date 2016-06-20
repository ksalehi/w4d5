Rails.application.routes.draw do
  resources :users, except: [:index] do
    get "prepare_to_destroy"
  end
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts, except: [:index] do
    resources :comments 
  end
end
