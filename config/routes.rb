Rails.application.routes.draw do
    # 顧客用
    # URL /customers/sign_in ...
    devise_for :users,skip: [:passwords], controllers: {
      registrations: "public/registrations",
      sessions: 'public/sessions'
    }
    root to: "public/homes#top"
    get "public/homes/about"=>"public/homes#about", as: 'about'
    
    # 顧客用 namespaceを使うと、全てのpathにpublic/が最初につく
    namespace :public do
      # :posts do patch....を追加すると/posts/:idにPATCHメソッドが送信されると、PostsControllerのupdateアクションが呼び出されるようになる?????
      resources :posts
    end
    
    # 管理者用
    # URL /admin/sign_in ...
    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
      sessions: "admin/sessions"
    }
    
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    
end