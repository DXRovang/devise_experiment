class BooksController < ApplicationController
  def index
    render plain: 'books'
  end

end
