class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :borrow_date, :return_date, :period, presence: true
  validate :return_date_is_after_borrow_date

  private

  def return_date_is_after_borrow_date
    return unless borrow_date.present? && return_date.present?

    errors.add(:return_date, 'cannot be before the borrow date') if return_date < borrow_date
  end
end
