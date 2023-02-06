class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :loan_date, :period, presence: true
  validate :return_date_is_after_loan_date

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
end
