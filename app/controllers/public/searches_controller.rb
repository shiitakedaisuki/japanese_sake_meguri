class Public::SearchesController < ApplicationController
  def search
    # rangeで検索範囲を判別している(User or Post)
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:search], params[:word])
    else
      @posts = Post.looks(params[:search], params[:word])
    end
  end
end