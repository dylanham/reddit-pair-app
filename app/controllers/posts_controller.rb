class PostsController < ApplicationController
  before_action :set_post, only:[:show, :edit, :update, :destroy]
  before_action :ensure_current_user, only:[:new, :create, :edit, :update, :destroy]
  before_action :ensure_current_user_is_owner, only:[:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    if post.save
      flash[:notice] = 'The Black Hole has recieved your post'
      redirect_to post_path(post)
    else
      @post = post
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "The Black Hole has accepted your changes"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "The Blackhole has swallowed your post!"
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:content, :title)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
