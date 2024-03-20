class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = current_user.posts.build
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to "/categories/posts/#{@category.id}"
    else
      render 'new'
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
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:title)
    end
end
