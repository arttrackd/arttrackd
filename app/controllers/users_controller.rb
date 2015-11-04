class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :dashboard]
  before_action :require_login, except: :new
  before_action :success_on_index, only: :dashboard

  def profile
    @user = @current_user
  end

  def index
    redirect_to profile_path
  end

  def show
    redirect_to profile_path
  end
  # GET /users/new
  def new
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
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
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
    @user = User.find(session[:user_id])
    redirect_to dashboard_user_path(session[:user_id]) if @user != @current_user

    @goals = SalesGoal.where('user_id = ?', @user.id)
    @projects = Project.where('user_id = ?', @user.id)
  end

  private

    def success_on_index # We're going to need to pass success a length of time and use that instead of sales_goals.all
      @user = User.find(session[:user_id])
      @goals = SalesGoal.where('user_id = ?', @user.id)
      @goals.each do |sg|
        @projects = @user.projects
        @sales = []
        @gross = []
        @projects.each do |project|
          @sales += project.sales
        end
        @sales.each do |s|
          @gross << s.gross
        end
        if @gross.count > 0
          @gross = @gross.reduce(:+)
          if @gross >= @user.sales_goals.sum('amount') && @user.sales_goals.sum('amount') != 0
            sg.success = true
            @user.save
          else
            sg.success = false
            @user.save
          end
        else
          sg.success = false
          @user.save
        end
      end
    end

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
