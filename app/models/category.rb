class Category < ApplicationRecord
  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :books
  # rubocop:enable Rails/HasManyOrHasOneDependent

  validates :name, presence: true
  validates :name, uniqueness: true
end
