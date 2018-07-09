Rails.application.routes.draw do
    #トップページのurl作成
    root to: 'toppages#index'
    
    get 'rankings/want' => 'rankings#want'
    
    # 新規作成用のフォームページのURL
    get 'login' => 'sessions#new'
    # 保存アクションのURL
    post'login' => 'sessions#create'
    delete 'logout' => 'sessions#destroy'
     
    # ユーザ登録用
    get 'signup' => 'users#new'
    # get 'users/:id' => 'users#show'
    # get 'users/new' => 'users#new'
    # post 'users' => 'users#create'
    resources :users, only:[:show, :new, :create]
    
    # get 'items/new' => 'items#new' 
    resources :items, only:[:new, :show]
    
    # post 'ownerships' => 'ownerships#create'
    resources :ownerships, only: [:create, :destroy]
end
