class ProjectsController < ApplicationController
  before_action :require_login
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  def index

    if params[:search]
      @projects = project_scope.search(params[:search])
    else
      @projects = project_scope.includes(:sales, :user, :time_entries).order('name')
      @projects = @projects.select{|project| project.sales.length > 0} if params[:sold]
    end
  end

  # GET /projects/1
  def show
    @project_time = @project.total_time
  end

  # GET /projects/new
  def new
    @project = Project.new
    @project.material_uses.build
    @project.project_costs.build
  end

  # GET /projects/1/edit
  def edit
    @project.material_uses.build
    @project.project_costs.build
  end

  # POST /projects
  def create
    @project = Project.new(project_params)
    @project.user = @current_user
    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      @project.save
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    if @project.destroy
      redirect_to projects_url, notice: 'Project was successfully destroyed.'
    else
      redirect_to projects_url, notice: 'Project cannot be destroyed.'
    end
  end

  private
    # So that people cannot PATCH and DELETE unless they are the @current_user
    def project_scope
      Project.where(user_id: @current_user.id)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      begin
        @project = project_scope.find(params[:id])
      rescue
        redirect_to dashboard_user_path(@current_user.id), notice: "Not found."
      end
    end

    # def set_material_use_names
    #   material_use_ids = params[:project][:material_uses_attributes]
    #   (1..100).each do |x|
    #     if material_use_ids[x.to_s]
    #       @project.material_uses[x].name = MaterialPurchase.find(material_use_ids[x.to_s][:material_purchase_id]).name
    #     else
    #       break
    #     end
    #   end
    #   byebug
    #   @project.save
    # end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(:user_id, :name, :description,
      project_costs_attributes: [:id, :cost_type, :amount, :user_id, :_destroy],
      material_uses_attributes: [:id, :material_purchase_id, :project_id, :user_id, :units, :_destroy])
    end
end
