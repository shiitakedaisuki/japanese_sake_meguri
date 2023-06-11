class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  # 投稿データの保存
  def create
    @post = Post.new(image_params)
    @post.user_id = current_user.id
    if @post.valid?
      @post.save
      flash[:notice] = "投稿が成功しました"
      redirect_to public_post_path(@post)
    else
      render :new
    end
  end
  
  
  def index
    @post = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if
      @post.update(post_params)
      redirect_to public_post_path(@post), notice: "投稿が更新されました"
    else
      render :edit
    end
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to public_posts_path
  end
  
  # 投稿データのストロングパラメータ
  private

  def image_params
    params.require(:post).permit(:name, :image, :review)
  end
  
end
