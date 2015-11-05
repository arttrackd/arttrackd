class MaterialUsesController < ApplicationController
  before_action :require_login
  before_action :set_material_use, only: [:show, :edit, :update, :destroy]

  # GET /material_uses
  def index
    @material_uses = MaterialUse.all
  end

  # GET /material_uses/1
  def show
  end

  # GET /material_uses/new
  def new
    @material_use = MaterialUse.new
  end

  # GET /material_uses/1/edit
  def edit
  end

  # POST /material_uses
  def create
    @material_use = MaterialUse.new(material_use_params)

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
    # Use callbacks to share common setup or constraints between actions.
    def set_material_use
      @material_use = MaterialUse.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def material_use_params
      params.require(:material_use).permit(:material_purchase_id, :project_id, :name, :description, :units)
    end
end
