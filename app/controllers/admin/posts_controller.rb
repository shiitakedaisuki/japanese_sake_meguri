class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def destroy
    post = Post.find(params[:id])
    if post.destroy
      redirect_to public_posts_path
    else
      redirect_to root_path, alert: "不正な操作です。"
    end
  end
end
