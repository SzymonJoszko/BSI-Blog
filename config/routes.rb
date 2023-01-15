Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, except: %i[new edit]
  resources :posts, except: %i[new edit]

  post 'sign_in', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  post 'sign_up', to: 'registrations#create'
end
