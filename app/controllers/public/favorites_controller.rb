class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post
  
  def create
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
    # 投稿一覧画面へリダイレクト
    redirect_to public_posts_path
  end

  def destroy
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
    redirect_to public_posts_path
  end
  
  private
  
  def find_post
    @post = Post.find(params[:post_id])
  end
end
