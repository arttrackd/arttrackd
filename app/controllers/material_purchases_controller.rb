class MaterialPurchasesController < ApplicationController
  before_action :set_material_purchase, only: [:show, :edit, :update, :destroy]

  # GET /material_purchases
  def index
    @material_purchases = MaterialPurchase.all
  end

  # GET /material_purchases/1
  def show
  end

  # GET /material_purchases/new
  def new
    @material_purchase = MaterialPurchase.new
  end

  # GET /material_purchases/1/edit
  def edit
  end

  # POST /material_purchases
  def create
    @material_purchase = MaterialPurchase.new(material_purchase_params)

    if @material_purchase.save
      redirect_to @material_purchase, notice: 'Material purchase was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /material_purchases/1
  def update
    if @material_purchase.update(material_purchase_params)
      redirect_to @material_purchase, notice: 'Material purchase was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /material_purchases/1
  def destroy
    @material_purchase.destroy
    redirect_to material_purchases_url, notice: 'Material purchase was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material_purchase
      @material_purchase = MaterialPurchase.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def material_purchase_params
      params.require(:material_purchase).permit(:user_id, :name, :description, :cost, :units)
    end
end
