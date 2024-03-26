class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    begin
      @category = Category.new(category_params)

      if @category.save
        redirect_to "/categories/posts/#{@category.id}"
      else
        render 'new'
      end
    rescue ActiveRecord::RecordNotUnique => e
      redirect_to '/500'
    end

    
  end

  def update
    if @category.update(category_params)
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    post = @category.posts

    if post
      @category.posts.delete
    end

    @category.destroy
    redirect_to categories_path
  end

  private
    def set_category
      begin
        @category = Category.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        redirect_to '/500'
      rescue ActiveRecord::RecordNotUnique => e
        redirect_to '/500', notice: "Category already exists"
      end
    end

    def category_params
      params.require(:category).permit(:title)
    end
end
