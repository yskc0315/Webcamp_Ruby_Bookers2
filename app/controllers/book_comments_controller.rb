class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = BookComment.new(book_comment_params)
    comment.user_id = current_user.id
    comment.book_id = book.id
    comment.save
    @comments = BookComment.where(book_id:params[:book_id])
  end

  def destroy
    BookComment.find_by(id:params[:id], book_id:params[:book_id]).destroy
    @comments = BookComment.where(book_id:params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
