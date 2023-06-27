class Public::UsersController < ApplicationController
   before_action :authenticate_user! , only: [:show, :index]
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end
  
  def index
    # is_deleted: false(退会していない)ユーザーのみ表示
    @users = User.where(is_deleted: false).page(params[:page])
  end
  
  def edit
    @user = current_user
  end
  
  def update
      @user = current_user
      if @user.update(user_params)
        redirect_to user_path(@user.id), notice: '更新が完了いたしました。'
      else
        render :edit,notice: '更新できませんでした。'
      end
  end
  
  def confirm
    @user = current_user
  end
    
  def quit
    # ログインしているカスタマーのis_deletedカラムをtrueで更新する
    current_user.update(is_deleted: true)
    # 強制的にログアウト状態にする
    reset_session
    redirect_to root_path, notice: '退会が完了いたしました。またのご利用をお待ちしております。'
  end
  
  #ストロングパラメータ
  private
  def user_params
    params.require(:user).permit(:user_name, :email, :profile_image, :password)
  end
  
end


