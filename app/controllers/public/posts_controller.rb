class Public::PostsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :edit]
  def new
    @post = Post.new
  end
  
  # 投稿データの保存
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # 変数名.アソシエーションで関係のあるテーブルの複数形の変数名.new(ジャンルidはパラメータから取ってきたジャンルのid)
    @post.post_genres.new(genre_id: Genre.find_by(name: genre_params).id)
    if @post.valid?
      @post.save
      flash[:notice] = "投稿しました"
      redirect_to post_path(@post)
    else
      render :new
    end
  end
  
  def index
    @post = Post.page(params[:page])
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
      redirect_to post_path(@post), notice: "投稿が更新されました"
    else
      render :edit
    end
  end
  
  def destroy
    post = Post.find(params[:id])
    if post.user_id == current_user.id
      post.destroy
      redirect_to posts_path
    else
      redirect_to root_path, alert: "不正な操作です。"
    end
  end
  
  # 投稿データのストロングパラメータ
  private

  def post_params
    params.require(:post).permit(:name, :image, :review)
  end
  
  def genre_params
    # 書き方は違うけど59行目と一緒の意味。エラーが出てしまうのでこの書き方
    params[:post][:genre_name]
  end
end
