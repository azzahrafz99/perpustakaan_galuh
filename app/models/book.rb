class Book < ApplicationRecord
  validates :title, :book_code, :author, :publisher, presence: true
  validates :book_code, uniqueness: true
end
