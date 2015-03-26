class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def ensure_current_user_is_owner
    if current_user.id != @post.user_id
      flash[:error] = "Hey! You can't do that. Silly"
      redirect_to root_path
    end
  end

  def ensure_comment_owner
    #if the current_user is not the owner of the comment aka the comments user_id is not the current users id
    if current_user.id != @comment.user_id
      flash[:error] = "Hey! You can't do that. Silly"
      redirect_to root_path
    end
  end

  def ensure_current_user
    if !current_user
      flash[:error] = 'Please sign in first'
      redirect_to sign_in_path
    end
  end
end
