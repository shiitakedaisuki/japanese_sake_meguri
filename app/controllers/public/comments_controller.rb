class Public::CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.post_id = post.id
    comment.save
    # 投稿の詳細画面にリダイレクト
    redirect_to public_post_path(post)
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to  public_post_path(params[:post_id])
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    @post = @comment.post # コメントに関連する投稿を取得する
    if @comment.update(comment_params)
      redirect_to public_post_path(@post), notice: "コメントが編集されました。"
    else
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
