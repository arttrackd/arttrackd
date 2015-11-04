class SalesGoalsController < ApplicationController
  before_action :require_login
  before_action :set_sales_goal, only: [:show, :edit, :update, :destroy]
  before_action :success_on_show, only: :show
  before_action :success_on_index, only: :index
  # GET /sales_goals
  def index
  end

  # GET /sales_goals/1
  def show
    redirect_to dashboard_user_path(session[:user_id]) if @user != @current_user
  end

  # GET /sales_goals/new
  def new
    @sales_goal = SalesGoal.new
  end

  # GET /sales_goals/1/edit
  def edit
    @user = @sales_goal.user
    redirect_to dashboard_user_path(session[:user_id]) if @user != @current_user
  end

  # POST /sales_goals
  def create
    @sales_goal = SalesGoal.new(sales_goal_params)

    if @sales_goal.save
      redirect_to @sales_goal, notice: 'Sales goal was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sales_goals/1
  def update
    if @sales_goal.update(sales_goal_params)
      redirect_to @sales_goal, notice: 'Sales goal was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sales_goals/1
  def destroy
    @sales_goal.destroy
    redirect_to sales_goals_url, notice: 'Sales goal was successfully destroyed.'
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

    def success_on_show # We're going to need to pass success a length of time and use that instead of sales_goals.all
      @user = @sales_goal.user
      redirect_to dashboard_user_path(session[:user_id]) if @user != @current_user
      @projects = @user.projects
      @sales = []
      @gross = []
      @projects.each do |project|
        @sales += project.sales
      end
      @sales.each do |s|
        @gross << s.gross
      end
      @gross = @gross.reduce(:+)
      if @gross
        if @gross >= @user.sales_goals.sum('amount') && @user.sales_goals.sum('amount') != 0
          @sales_goal.success = true
          @user.save
        else
          @sales_goal.success = false
          @user.save
        end
      else
        @sales_goal.success = false
        @user.save
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_sales_goal
      begin
        @sales_goal = SalesGoal.find(params[:id])
      rescue
        redirect_to dashboard_user_path(@current_user.id), notice: "Could not find that goal."
      end
    end

    # Only allow a trusted parameter "white list" through.
    def sales_goal_params
      params.require(:sales_goal).permit(:user_id, :amount, :length_of_time, :start_time)
    end
end
