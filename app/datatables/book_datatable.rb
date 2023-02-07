class BookDatatable < AjaxDatatablesRails::ActiveRecord
  include ApplicationHelper
  extend Forwardable

  def_delegators :@view, :raw, :link_to, :safe_join, :current_user,
                 :book_path, :edit_book_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      isbn: { source: 'Book.isbn', cond: :like },
      title: { source: 'Book.title', cond: :like },
      author: { source: 'Book.author', cond: :like },
      stock: { source: 'Book.stock', cond: :like },
      actions: { searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        isbn: record.isbn,
        title: record.title,
        author: record.author,
        stock: record.stock,
        actions: actions(record),
        DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    Book.all
  end

  def actions(book)
    links = []
    links << show_link(book)
    links << edit_link(book) if admin?
    links << delete_link(book) if admin?
    safe_join(links)
  end

  private

  def show_link(book)
    link_to(book_path(book), class: 'btn btn-sm btn-info', id: "show-book-#{book.id}") do
      raw '<i class="fa fa-eye"></i>'
    end
  end

  def delete_link(book)
    link_to(book_path(book),
            method: :delete,
            class: 'btn btn-sm btn-danger',
            id: "delete-book-#{book.id}",
            data: { confirm: I18n.t('labels.delete_book_confirmation') }) do
      raw '<i class="fa fa-trash"></i>'
    end
  end

  def edit_link(book)
    link_to(edit_book_path(book), id: "edit-book-#{book.id}", class: 'btn btn-sm btn-warning') do
      raw '<i class="fa fa-pencil"></i>'
    end
  end
end
