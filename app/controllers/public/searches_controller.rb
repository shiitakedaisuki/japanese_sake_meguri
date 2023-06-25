class Public::SearchesController < ApplicationController
  def search
    # rangeで検索範囲を判別している(User or Review or Name)
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:search], params[:word]).where(is_deleted: false)
      if @users.blank?
        flash[:notice] = "一致するユーザーがなかったため、全件を表示します。"
        # 全件を表示する(退会しているユーザー以外)
        @users = User.where(is_deleted: false)
      end
    elsif @range == "Review"
      # .left_joins(:アソシエーション先名).where(結合先のテーブル名: { カラム名: 値 })で退会しているユーザー以外のレビューに絞る
      @posts = Post.looks(params[:search], params[:word]).left_joins(:user).where(user: { is_deleted: false })
      if @posts.blank?
        flash[:notice] = "一致する投稿がなかったため、全件を表示します。"
        # 全件を表示する(退会しているユーザー以外)
        @posts = Post.left_joins(:user).where(user: { is_deleted: false })
      end
    elsif @range == "Name"
      # .left_joins(:アソシエーション先名).where(結合先のテーブル名: { カラム名: 値 })で退会しているユーザー以外のレビューに絞る
      @posts = Post.name_looks(params[:search], params[:word]).left_joins(:user).where(user: { is_deleted: false })
      if @posts.blank?
        flash[:notice] = "一致する投稿がなかったため、全件を表示します。"
        # 全件を表示する(退会しているユーザー以外)
        @posts = Post.left_joins(:user).where(user: { is_deleted: false })
      end
    end
  end
end