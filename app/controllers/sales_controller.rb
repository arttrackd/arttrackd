class SalesController < ApplicationController
  before_action :require_login
  before_action :set_sale, only: [:show, :edit, :update, :destroy]
  after_action :net, only: :create #Write this method once we have expenses tables
  after_action :update_goals, only: [:create, :update, :destroy]
  # GET /sales
  def index
    # We need a button to show more, either Ajax or navigate to page of next 50 or all
    if params[:search]
      q = "%#{params[:search]}%"
      s = Sale.includes(:sales_channel, :project).joins(:project).where(projects: {user_id: @current_user.id})
      @sales = Sale.search(s, q)
    else
      @sales = Sale.includes(:sales_channel, :project).joins(:project).where(projects: {user_id: @current_user.id})
    end
  end

  # GET /sales/1
  def show
    redirect_to dashboard_user_path(session[:user_id]) unless @sale.project.user == @current_user
  end

  # GET /sales/new
  def new
    if params[:project_id]
      @project_name = Project.find(params[:project_id]).name
      @sale = Sale.new
      @sales_channels = SalesChannel.where(user_id: @current_user.id)
    else
      redirect_to dashboard_user_path(session[:user_id]), notice: "You must mark a project as sold to create a sale record."
    end
  end

  # GET /sales/1/edit
  def edit
    redirect_to dashboard_user_path(session[:user_id]) unless @sale.project.user == @current_user
    @sales_channels = SalesChannel.where(user_id: @current_user.id)
  end

  # POST /sales
  def create
    @sale = Sale.new(sale_params)

    if @sale.save
      redirect_to @sale, notice: 'Sale record was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sales/1
  def update
    if @sale.update(sale_params)
      redirect_to @sale, notice: 'Sale record was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sales/1
  def destroy
    @sale.destroy
    redirect_to sales_url, notice: 'Sale record was successfully destroyed.'
  end

  # def search
  #   if params[:search]
  #   @sale = Sale.where("date LIKE ?", "%#{params[:search]}%")
  #   # sales = Sale.where("date LIKE ?", "%#{params[:search]}%")
  #   # projects = Project.where("name LIKE ?", "%#{params[:search]}%")
  #   # mix = sale + project
  #   # @sale = sales.select{|sale| sale.date sale.project.name}
  #   end
  # end

  private

    def net
      return true
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      begin
        @sale = Sale.find(params[:id])
      rescue
        redirect_to dashboard_user_path(@current_user.id), notice: "Could not find that sale record."
      end
    end

    # Only allow a trusted parameter "white list" through.
    def sale_params
      params.require(:sale).permit(:sales_channel_id, :project_id, :gross, :date)
    end

    def update_goals
      SalesGoal.update_goals(@current_user.id)
    end
end
