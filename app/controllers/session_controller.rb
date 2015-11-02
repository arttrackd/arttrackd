class SessionController < ApplicationController

  def new
   redirect_to dashboard_path if logged_in?
  end

  def create
    user = User.find_by_email(session_params[:email])
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Welcome!'
      redirect_to dashboard_path
    else
      flash[:error] = 'Invalid email/password combination'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:alert] = 'Logged out.'
    redirect_to login_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

end
