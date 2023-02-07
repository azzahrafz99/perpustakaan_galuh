class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :loan_date, :period, presence: true
  validate :return_date_is_after_loan_date
  validate :validate_same_book

  after_create :decrease_stock

  def status
    current_date = Date.current
    return 'done' if return_date.present?
    return 'delayed' if current_date > borrow_until

    'on going'
  end

  def borrow_until
    loan_date + period.days
  end

  private

  def return_date_is_after_loan_date
    return unless loan_date.present? && return_date.present?

    errors.add(:return_date, 'cannot be before the loan date') if return_date < loan_date
  end

  def decrease_stock
    book.update(stock: book.stock - 1)
  end

  def validate_same_book
    # User can not borrow the same book if they have not return that book yet
    transactions = Transaction.where(user_id: user_id, book_id: book_id, return_date: nil)
    return if transactions.blank?

    errors.add(:base, 'can not borrow the same book that you have not return yet')
  end
end
