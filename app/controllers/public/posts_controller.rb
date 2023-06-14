class Public::PostsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :edit]
  def new
    @post = Post.new
  end
  
  # 投稿データの保存
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.valid?
      @post.save
      flash[:notice] = "投稿しました"
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
    @comment = Comment.new
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
    # ||はorという意味。AかBどちらかがtrueだったら実行される
    if post.user_id == current_user.id || current_admin
      post.destroy
      redirect_to public_posts_path
    else
      redirect_to root_path, alert: "不正な操作です。"
    end
  end
  
  # 投稿データのストロングパラメータ
  private

  def post_params
    params.require(:post).permit(:name, :image, :review)
  end
  
end
