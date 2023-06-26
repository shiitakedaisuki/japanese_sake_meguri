# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
  def after_sign_in_path_for(resource)
    posts_path
  end
  def after_sign_out_path_for(resource)
    root_path
  end

  protected
  # 退会しているかを判断するメソッド
  def user_state
    ## 【処理内容1】 入力されたemailからアカウントを1件取得
    @user = User.find_by(email: params[:user][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@user
    ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
      if @user.valid_password?(params[:user][:password]) && @user.is_deleted == true
      ##trueだった場合、サインアップ画面に遷移する処理を実行する
      redirect_to new_user_registration_path, notice: '既に退会済みです。新規登録してください。同じアドレスは使用できません。'
      ##falseだった場合、createアクションを実行させる(勝手に上のbefore_action :customer_state, only: [:create]に行くので記載はいらない)
    end
  end

  
  
end
