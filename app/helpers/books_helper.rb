module BooksHelper
  def book_status_badge(book)
    status     = book.available? ? 'available' : 'unavailable'
    class_name = book.available? ? 'success' : 'danger'
    "<span class='badge badge-pill badge-#{class_name}'>#{status}</span>".html_safe
  end
end
