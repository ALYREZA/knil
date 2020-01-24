Rails.application.routes.draw do

  root to: 'pages#root'
  scope '/admin' do
    
    # index of
    get "/", to: 'users#show', as: 'show_user'
    
    # links path
    resources :links
    
    # edit
    get "edit", to: 'users#edit', as: 'edit_user'
    patch "edit", to: 'users#update'
    
    # register
    get 'register', to: 'users#new', as: 'register'
    post 'register', to: 'users#create'
    
    # login
    get 'login', to: 'sessions#new', as: 'login'
    post 'login', to: 'sessions#create'
    
    # logout
    get 'logout', to: 'sessions#destroy', as: 'logout'

    get 'verify/:id', to: 'users#verify', as: 'verify'
    
  end

  get "l/:id", to: "links#goto", as: "goto"
  get "/:username", to: "links#api", as: "api"


end
