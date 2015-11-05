class SalesController < ApplicationController
  before_action :require_login
  before_action :set_sale, only: [:show, :edit, :update, :destroy]
  after_action :net, only: :create #Write this method once we have expenses tables
  after_action :update_goals, only: [:create, :update, :destroy]
  # GET /sales
  def index
    @project = Project.all
    @user = User.find(session[:user_id])
    redirect_to dashboard_user_path(session[:user_id]) if @user != @current_user
    @sales = Sale.where(project_id: Project.where(user_id: @user.id)).limit(50)
    # We need a button to show more, either Ajax or navigate to page of next 50 or all
  end

  # GET /sales/1
  def show
    @user = @sale.project.user
    redirect_to dashboard_user_path(session[:user_id]) unless @user == @current_user
  end

  # GET /sales/new
  def new
    if params[:project_id]
      @project_name = Project.find(params[:project_id]).name
      @sale = Sale.new
    else
      redirect_to dashboard_user_path(session[:user_id]), notice: "You must mark a project as sold to create a sale."
    end
  end

  # GET /sales/1/edit
  def edit
    @user = @sale.project.user
    redirect_to dashboard_user_path(session[:user_id]) unless @user == @current_user
  end

  # POST /sales
  def create
    @sale = Sale.new(sale_params)

    if @sale.save
      redirect_to @sale, notice: 'Sale was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sales/1
  def update
    if @sale.update(sale_params)
      redirect_to @sale, notice: 'Sale was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sales/1
  def destroy
    @sale.destroy
    redirect_to sales_url, notice: 'Sale was successfully destroyed.'
  end

  private

    def net
      return true
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      begin
        @sale = Sale.find(params[:id])
      rescue
        redirect_to dashboard_user_path(@current_user.id), notice: "Could not find that sale."
      end
    end

    # Only allow a trusted parameter "white list" through.
    def sale_params
      params.require(:sale).permit(:project_id, :gross, :date)
    end

    def update_goals
      SalesGoal.update_goals(@current_user.id)
    end
end
