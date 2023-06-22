class Admin::SearchController < ApplicationController
  def search
    # rangeで検索範囲を判別している(User or Review or Name)
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
      if @users.blank?
        flash[:notice] = "一致するユーザーがなかったため、全件を表示します。"
        @users = User.all
      end
    elsif @range == "Review"
      @posts = Post.looks(params[:search], params[:word])
      if @posts.blank?
        flash[:notice] = "一致する投稿がなかったため、全件を表示します。"
        @posts = Post.all
      end
    elsif @range == "Name"
      @posts = Post.name_looks(params[:search], params[:word])
      if @posts.blank?
        flash[:notice] = "一致する投稿がなかったため、全件を表示します。"
        @posts = Post.all
      end
    end
  end
end
