class BooksController < ApplicationController
  
  before_action :authenticate_user!


  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "created book successfully!!"
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      flash.now[:alert] = "error prohibited this obj from being saved:"
      render :index
    end
  end

  def show
    @book = Book.new
    @book_find = Book.find(params[:id])
    @user = @book_find.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "updated book successfully!!"
      redirect_to book_path(@book.id)
    else
      flash.now[:alert] = "error prohibited this obj from being saved:"
      render :edit
    end
  end


  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  private


  def book_params
    params.require(:book).permit(:title, :body, :profile_image)
  end
  
end
