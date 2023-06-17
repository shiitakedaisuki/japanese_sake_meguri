class Public::UsersController < ApplicationController
  def show
    @user = current_user
    @posts = @user.posts.page(params[:page])
  end
  
  def index
    @users = User.page(params[:page])
  end
  
  def edit
    @user = current_user
  end
  
  def update
      user = current_user
      if user.update(user_params)
        redirect_to public_users_show_path, notice: '更新が完了いたしました。'
      else
        redirect_to public_users_edit_path, notice: '更新できませんでした。'
      end
  end
  
  def confirm
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


