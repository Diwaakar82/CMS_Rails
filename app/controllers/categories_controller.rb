class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]

  # GET /categories or /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/new
  def new
  end

  # GET /categories/1/edit
  def edit
    
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)
    @category.save

    redirect_to @category
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    if @category.update(category_params)
      redirect_to @category
    else
      render 'edit'
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy

    redirect_to categories_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:title)
    end
end
