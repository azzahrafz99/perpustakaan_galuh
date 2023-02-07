class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  def index
    respond_to do |format|
      format.html
      format.json { render json: BookDatatable.new(params, view_context: view_context) }
    end
  end

  def show; end

  def new
    @book = Book.new
    authorize @book
  end

  def edit
    authorize @book
  end

  def create
    @book = Book.new(book_params)
    authorize @book

    if @book.save
      redirect_to book_url(@book), notice: 'Book was successfully created.'
    else
      flash[:error] = @book.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @book

    if @book.update(book_params)
      redirect_to book_url(@book), notice: 'Book was successfully updated.'
    else
      flash[:error] = @book.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @book

    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit :title, :summary, :isbn, :author,
                                 :language, :publisher, :stock, :category_id
  end
end
