class Admin::CommentsController < ApplicationController
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to  public_post_path(params[:post_id])
  end
end