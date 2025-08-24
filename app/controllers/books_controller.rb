class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @book  = Book.new
    @books = Book.order(:id)  # ID昇順
  end

  def show
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book), notice: "Book was successfully created."
    else
      @books = Book.order(:id)
      flash.now[:alert] = "error: failed to create Book."
      render :index, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "Book was successfully updated."
    else
      flash.now[:alert] = "error: failed to update Book."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: "Book was successfully destroyed."
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
