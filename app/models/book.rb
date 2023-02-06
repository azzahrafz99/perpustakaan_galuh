class Book < ApplicationRecord
  belongs_to :category

  has_many :transactions

  validates :title, :book_code, :author, :publisher, presence: true
  validates :book_code, uniqueness: true
end
