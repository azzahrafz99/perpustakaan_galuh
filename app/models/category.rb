class Category < ApplicationRecord
  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :books
  # rubocop:enable Rails/HasManyOrHasOneDependent

  validates :name, presence: true
  validates :name, uniqueness: true

  before_destroy do
    cannot_delete_if_in_use
    throw(:abort) if errors.present?
  end

  private

  def cannot_delete_if_in_use
    return if books.blank?

    errors.add(:base, 'Can not delete in used category')
  end
end
