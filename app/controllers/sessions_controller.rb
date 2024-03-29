class SessionsController < ApplicationController

  before_action :logged_in_redirect, only: [:new, :create]

  def new

  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You're in!"
      redirect_to root_path
    else
      flash.now[:error] = "Oupsy looks like you made a mistake, have an other try"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "See you soon!"
    redirect_to login_path
  end

  private

  def logged_in_redirect
    if logged_in?
      flash[:success] = "You are already logged in"
    end
  end

end
