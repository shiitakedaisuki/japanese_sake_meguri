class Admin::UsersController < ApplicationController
   before_action :authenticate_admin!
   
    def index
      @users = User.page(params[:page])
    end
    
    def show
      @user = User.find(params[:id])
      @posts = @user.posts.page(params[:page])
    end
    
    def update
        user = User.find(params[:id])
        if user.update(user_params)
          redirect_to public_users_show_path, notice: '更新が完了いたしました。'
        else
          redirect_to public_users_edit_path, notice: '更新できませんでした。'
        end
    end
    
    def quit
      user = User.find(params[:id])
      # ログインしているカスタマーのis_deletedカラムをtrueで更新する
      user.update(is_deleted: true)
      # 強制的にログアウト状態にする
      redirect_to admin_users_path
    end
    
    
end
