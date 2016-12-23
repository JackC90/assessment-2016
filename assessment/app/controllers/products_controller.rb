class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index 
    if params[:search]
      filtering_params = params[:search].slice(:search_string, :search_isbn, :category, :product_format, :language, :price_above, :price_below, :sale_or_rent, :pages_above, :pages_below)
      @products = Product.filter(filtering_params)
      # byebug
    else 
      @products = Product.all
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
      @order = @product.orders.new(user_id: current_user.id) if user_signed_in?
  end

  # GET /products/new
  def new
    @product = current_user.products.new
  end

  # GET /products/1/edit
  def edit    
    unless user_signed_in? && owner_or_admin?(@product)
      respond_to do |format|
        format.html { redirect_to @product }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /products
  # POST /products.json
  def create
    if user_signed_in?
      @product = Product.new(product_params)
      respond_to do |format|
        if @product.save
          format.html { redirect_to @product, notice: 'Product was successfully created.' }
          format.json { render :show, status: :created, location: @product }
        else
          format.html { render :new }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy  
    if user_signed_in? && owner_or_admin?(@product)
      @product.destroy
      respond_to do |format|
        format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:title, :price, :category, :sale_or_rent, :description, :ages, :format, :pages, :publication_date, :publisher, :publication_city, :language, :isbn, :user_id, :stock, {product_images: []})
    end
end
