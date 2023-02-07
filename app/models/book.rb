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
end
