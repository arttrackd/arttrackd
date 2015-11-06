class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :dashboard]
  before_action :require_login, except: [:new, :create]

  def profile
    @user = @current_user
    @projects = Project.where(user: @user).limit(5)
    @sales = Sale.where(project_id: Project.where(user_id: @user.id))
  end

  def index
    redirect_to profile_path
  end

  def show
    redirect_to profile_path
  end
  # GET /users/new
  def new
    redirect_to dashboard_user_path(session[:user_id]) if logged_in?
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    redirect_to dashboard_user_path(session[:user_id]) if @user != @current_user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to profile_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to profile_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  def dashboard
    redirect_to dashboard_user_path(session[:user_id]) unless @user == @current_user
    @goals = SalesGoal.where('user_id = ?', @user.id).limit(5)
    @goal = SalesGoal.last
    @percent_completion = SalesGoal.percent_completion(@goal)
    @projects = Project.where('user_id = ?', @user.id).limit(5)
    @sales = Sale.where(project_id: Project.where(user_id: @user.id)).limit(5)
    render :layout => 'dashboard_layout'
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      begin
        @user = User.find(params[:id])
      rescue
        redirect_to login_path
      end
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :public_profile, :time_zone, :hourly_rate)
    end
end
