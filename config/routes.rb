Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :posts do
    resources :comments
  end
  # You can have the root of your site routed with "root"
  root 'posts#index'

  get 'sign-up', to: 'registrations#new'
  post 'sign-up', to: 'registrations#create'

  get 'sign-in', to: 'authentications#new'
  post 'sign-in', to: 'authentications#create'
  get 'sign-out', to: 'authentications#destroy'

end
