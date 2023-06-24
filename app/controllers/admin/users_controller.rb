class Admin::UsersController < ApplicationController
   before_action :authenticate_admin!
   
    def index
      @users = User.page(params[:page])
    end
    
    def show
      @user = User.find(params[:id])
      @posts = @user.posts.page(params[:page])
    end
    
    def quit
      user = User.find(params[:id])
      # ログインしているカスタマーのis_deletedカラムをtrueで更新する
      user.update(is_deleted: true)
      # 強制的にログアウト状態にする
      redirect_to admin_users_path
    end
    
    
end
