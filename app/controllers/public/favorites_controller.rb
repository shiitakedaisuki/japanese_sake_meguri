class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post
  
  def create
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
  end

  def destroy
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
  end
  
  private
  
  def find_post
    @post = Post.find(params[:post_id])
  end
end
