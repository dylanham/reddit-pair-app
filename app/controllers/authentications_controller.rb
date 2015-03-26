class AuthenticationsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome #{user.username}!"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
