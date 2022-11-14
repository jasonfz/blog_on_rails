Rails.application.routes.draw do
  # get 'session/new'
  # get 'session/create'
  # get 'session/destory'

  resource :session, only:[:new, :create, :destroy]


  resources :users, only: [:new, :create, :edit, :update]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :posts do 
    resources :comments, only: [:create, :destroy]
end

root "posts#index"

end 
