class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_product, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :user_signed_in?, except: [:show]

  # GET /reviews
  # GET /reviews.json

  # GET /reviews/1
  # GET /reviews/1.json

  def show
  end

  # GET /reviews/new
  def new
    @review = @product.reviews.new(user_id: current_user.id)
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = @product.reviews.new(review_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @review.save 
        format.html { redirect_to @product, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
        format.js
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @product, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to @product, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:title, :text, :rating, :user_id)
    end
end
