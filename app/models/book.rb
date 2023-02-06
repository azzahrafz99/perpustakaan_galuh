class Book < ApplicationRecord
  belongs_to :category

  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :transactions
  # rubocop:enable Rails/HasManyOrHasOneDependent

  validates :title, :book_code, :author, :publisher, presence: true
  validates :book_code, uniqueness: true
end
