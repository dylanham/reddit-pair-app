class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only:[:edit, :update, :destroy]
  before_action :ensure_current_user
  before_action :ensure_comment_owner, except:[:create]

  def create
    comment = @post.comments.new(comment_params)
    comment.user_id = current_user.id
    if comment.save
      flash[:notice]= "Comment added"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:notice] = 'Mountains are Merely Mountains. Way to update that comment!'
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "GOODBYE COMMENT!"
    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
