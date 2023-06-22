Rails.application.routes.draw do
    # 顧客用
    # URL /users/sign_in ...
    devise_for :users,skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
    }
    # devise_scopeは、deviseで新しいアクションを作る際に使用する
    devise_scope :user do
      post 'guest_sign_in', to: 'public/sessions#guest_sign_in'
    end
    
    # 管理者用
    # URL /admin/sign_in ...
    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
      sessions: "admin/sessions"
    }
    
    
    root to: "public/homes#top"
    get "public/homes/about"=>"public/homes#about", as: 'about'
    
    # scope moduleを使用してurlにpublicがつかないようにする
    scope module: :public do
      # :posts do patch....を追加すると/posts/:idにPATCHメソッドが送信されると、PostsControllerのupdateアクションが呼び出されるようになる
      resources :genres, only: [:index]
      resources :posts do
        collection do
          get 'genre/:id' =>'posts#genre', as: 'genre'
        end
        resource :favorites, only: [:create, :destroy]
        resources :comments, only: [:create, :edit, :update, :destroy]
      end
      resources :users
      get "search" => "searches#search"
      get "users/confirm"=>"users#confirm", as: 'users_confirm'
    end
    
    # 管理者用 namespaceを使うと、全てのpathにadmin/が最初につく
    namespace :admin do
      root to: "homes#top"
      resources :posts, only:[:index, :show ,:destroy] do
        resources :comments, only: [:destroy]
      end
      resources :genres
      get "search" => "searches#search"
      resources :users, only:[:index, :update, :show]
      # "users/:id/quit"は退会したい人のuseridをコントローラーに渡すために/:id/を入れる
      patch "users/:id/quit"=>"users#quit", as: 'users_quit'
    end
end