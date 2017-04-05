class SessionsController < ApplicationController
  def new
  end

  def create
    # we have user's email and password
    # find user by their email
    # then (if user is found) we call `authenticate` to make sure they
    # entered the correct password
    user = User.find_by_email params[:email]
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Thank you for signing in'
    else
      flash.now[:alert] = 'Wrong credentials!'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Signed Out'
  end
end
