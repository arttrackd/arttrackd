class SalesGoalsController < ApplicationController
  before_action :require_login
  before_action :set_sales_goal, only: [:show, :edit, :update, :destroy]

  # GET /sales_goals
  def index
    @sales_goals = SalesGoal.all
  end

  # GET /sales_goals/1
  def show
  end

  # GET /sales_goals/new
  def new
    @sales_goal = SalesGoal.new
  end

  # GET /sales_goals/1/edit
  def edit
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
    # Use callbacks to share common setup or constraints between actions.
    def set_sales_goal
      @sales_goal = SalesGoal.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sales_goal_params
      params.require(:sales_goal).permit(:user_id, :amount, :length_of_time, :start_time)
    end
end
