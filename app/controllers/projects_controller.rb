class ProjectsController < ApplicationController
  before_action :require_login
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  def index
    # @projects = Project.joins(:sales).where(projects: {user_id: @current_user.id})
    @projects = Project.includes(:sales, :user, :time_entries).where(user: @current_user)
  end

  # GET /projects/1
  def show
    @user = @project.user
    redirect_to dashboard_user_path(session[:user_id]) if @user != @current_user
    @project_time = @project.total_time
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
    @user = @project.user
    redirect_to dashboard_user_path(session[:user_id]) if @user != @current_user
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
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      begin
        @project = Project.find(params[:id])
      rescue
        redirect_to dashboard_user_path(@current_user.id), notice: "Could not find that project."
      end
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(:user_id, :name, :description)
    end
end
