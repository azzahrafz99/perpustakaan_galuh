class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: CategoryDatatable.new(params, view_context: view_context) }
    end
  end

  def show; end

  def new
    @category = Category.new
    authorize @category
  end

  def edit
    authorize @category
  end

  def create
    @category = Category.new(category_params)
    authorize @category

    if @category.save
      redirect_to category_url(@category), notice: 'Category was successfully created.'
    else
      flash[:error] = @category.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @category

    if @category.update(category_params)
      redirect_to category_url(@category), notice: 'Category was successfully updated.'
    else
      flash[:error] = @category.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @category

    if @category.destroy
      redirect_to categories_path, notice: 'Category was successfully destroyed.'
    else
      flash[:error] = @category.errors.full_messages.to_sentence
      redirect_to categories_path
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit :name
  end
end
