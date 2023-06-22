class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_posts_path, notice: '削除しました。'
  end
  
  def index
    @posts = Post.page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end
  
end
