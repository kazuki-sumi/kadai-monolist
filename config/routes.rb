Rails.application.routes.draw do
    #トップページのurl作成
    root to: 'toppages#index'
    
    # ユーザ登録用
    get 'signup' => 'users#new'
    
    # get 'users/:id' => 'users#show'
    # get 'users/new' => 'users#new'
    # post 'users' => 'users#create'
    resources :users, only:[:show, :new, :create]
end
