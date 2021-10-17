class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[create new]

  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:warning] = 'invalid Credentials'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Successfully Logged Out!'
    redirect_to login_path
  end
end
