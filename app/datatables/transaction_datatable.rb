class TransactionDatatable < AjaxDatatablesRails::ActiveRecord
  include ApplicationHelper
  include TransactionsHelper
  extend Forwardable

  def_delegators :@view, :raw, :link_to, :safe_join, :current_user,
                 :transaction_path, :edit_transaction_path,
                 :book_path

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      isbn: { source: 'Book.isbn', cond: :like },
      book_title: { source: 'Book.title', cond: :like },
      user: { source: 'User.email', cond: :like },
      loan_date: { source: 'Transaction.loan_date', cond: :like },
      period: { source: 'Transaction.period', cond: :like },
      status: { source: 'Transaction.status', searchable: false, orderable: false },
      actions: { searchable: false, orderable: false }
    }
  end

  def data
    records.map do |record|
      {
        isbn: book_link_by_isbn(record.book), book_title: book_link(record.book),
        user: record.user&.email, loan_date: record.loan_date,
        period: "#{record.period} days", status: transaction_status_badge(record.status),
        actions: actions(record), DT_RowId: record.id
      }
    end
  end

  def get_raw_records
    transactions = Transaction.joins(:book, :user)
    admin? ? transactions : transactions.where(user_id: current_user.id)
  end

  def actions(transaction)
    links = []
    links << show_link(transaction)
    links << edit_link(transaction) if admin?
    links << delete_link(transaction) if admin?
    safe_join(links)
  end

  private

  def book_link(book)
    link_to book&.title, book_path(book)
  end

  def book_link_by_isbn(book)
    link_to book&.isbn, book_path(book)
  end

  def show_link(transaction)
    link_to(transaction_path(transaction), class: 'btn btn-sm btn-info', target: '_top',
                                           id: "show-transaction-#{transaction.id}") do
      raw '<i class="fa fa-eye"></i>'
    end
  end

  def delete_link(transaction)
    link_to(transaction_path(transaction),
            method: :delete,
            class: 'btn btn-sm btn-danger',
            id: "delete-transaction-#{transaction.id}",
            target: '_top',
            data: { confirm: I18n.t('labels.delete_transaction_confirmation') }) do
      '<i class="fa fa-trash"></i>'.html_safe
    end
  end

  def edit_link(transaction)
    link_to(edit_transaction_path(transaction), id: "edit-transaction-#{transaction.id}",
                                                target: '_top',
                                                class: 'btn btn-sm btn-warning') do
      '<i class="fa fa-pencil"></i>'.html_safe
    end
  end
end
