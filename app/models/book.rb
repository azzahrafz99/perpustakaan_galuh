class Book < ApplicationRecord
  belongs_to :category

  validates :title, :book_code, :author, :publisher, presence: true
  validates :book_code, uniqueness: true
end
