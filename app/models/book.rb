class Book < ApplicationRecord
  belongs_to :category

  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :transactions
  # rubocop:enable Rails/HasManyOrHasOneDependent

  validates :title, :isbn, :author, :publisher, presence: true
  validates :isbn, uniqueness: true

  scope :available, -> { where('stock > ?', 0) }

  def available?
    stock.positive?
  end

  before_destroy do
    cannot_delete_if_in_use
    throw(:abort) if errors.present?
  end

  private

  def cannot_delete_if_in_use
    on_process_transactions = Transaction.on_process.where(book_id: id)
    return unless on_process_transactions.any?

    errors.add(:base,
               'Can not delete book that have not returned yet')
  end
end
