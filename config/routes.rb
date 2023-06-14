Rails.application.routes.draw do
    # 顧客用
    # URL /users/sign_in ...
    devise_for :users,skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
    }
    root to: "public/homes#top"
    get "public/homes/about"=>"public/homes#about", as: 'about'
    
    # 顧客用 namespaceを使うと、全てのpathにpublic/が最初につく
    namespace :public do
      # :posts do patch....を追加すると/posts/:idにPATCHメソッドが送信されると、PostsControllerのupdateアクションが呼び出されるようになる?????
      resources :posts do
        resource :favorites, only: [:create, :destroy]
        resources :comments, only: [:create, :edit, :update, :destroy]
      end
      get "search" => "searches#search"
      # URLを指定したいのでresourcesは使用できない。
      get "users/infomation/my_page"=>"users#show", as: 'users_show'
      get "users/infomation/edit"=>"users#edit", as: 'users_edit'
      patch "users/infomation/my_page"=>"users#update", as: 'users_update'
      get "users/confirm"=>"users#confirm", as: 'users_confirm'
      patch "users/quit"=>"users#quit", as: 'users_quit'
    end
    
    # 管理者用
    # URL /admin/sign_in ...
    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
      sessions: "admin/sessions"
    }
     # 管理者用
  namespace :admin do
    root to: "homes#top"
    resources :users, only:[:index, :show, :edit, :update] do
    end
  end
    
end