class ProjectCostsController < ApplicationController
  before_action :require_login
  before_action :set_project_cost, only: [:show, :edit, :update, :destroy]

  # GET /project_costs
  def index
    @project_costs = ProjectCost.all
  end

  # GET /project_costs/1
  def show
  end

  # GET /project_costs/new
  def new
    @project_cost = ProjectCost.new
  end

  # GET /project_costs/1/edit
  def edit
  end

  # POST /project_costs
  def create
    @project_cost = ProjectCost.new(project_cost_params)

    if @project_cost.save
      redirect_to @project_cost, notice: 'Project cost was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /project_costs/1
  def update
    if @project_cost.update(project_cost_params)
      redirect_to @project_cost, notice: 'Project cost was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /project_costs/1
  def destroy
    @project_cost.destroy
    redirect_to project_costs_url, notice: 'Project cost was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_cost
      @project_cost = ProjectCost.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_cost_params
      params.require(:project_cost).permit(:project_id, :cost_type, :amount)
    end
end
