class MaterialUsesController < ApplicationController
  before_action :require_login
  before_action :set_material_use, only: [:show, :edit, :update, :destroy]

  # GET /material_uses
  def index
    if params[:search]
      mu = material_use_scope
      @projects = MaterialUse.search(mu, params[:search])
    else
      @projects = Project.where(user_id: @current_user.id)
    end
  end

  # GET /material_uses/1
  def show
  end

  # GET /material_uses/new
  def new
    @material_use = MaterialUse.new
    @project = Project.where(user_id: @current_user.id)
  end

  # GET /material_uses/1/edit
  def edit
    @project = Project.where(user_id: @current_user.id)
  end

  # POST /material_uses
  def create
    @material_use = MaterialUse.new(material_use_params)
    @material_use.material_purchase.user = @current_user
    if @material_use.save
      redirect_to @material_use, notice: 'Material use was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /material_uses/1
  def update
    if @material_use.update(material_use_params)
      redirect_to @material_use, notice: 'Material use was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /material_uses/1
  def destroy
    @material_use.destroy
    redirect_to material_uses_url, notice: 'Material use was successfully destroyed.'
  end

  private
    # So that people cannot PATCH and DELETE unless they are the @current_user
    def material_use_scope
      MaterialUse.where(project_id: Project.where(user_id: @current_user.id).pluck(:id))
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_material_use
      begin
        @material_use = material_use_scope.find(params[:id])
      rescue
        redirect_to dashboard_user_path(@current_user.id), notice: "Not found."
      end
    end
    # Only allow a trusted parameter "white list" through.
    def material_use_params
      params.require(:material_use).permit(:user_id, :material_purchase_id, :project_id, :units, :_delete)
    end
end
