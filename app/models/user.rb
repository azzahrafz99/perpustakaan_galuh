class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true

  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :transactions
  # rubocop:enable Rails/HasManyOrHasOneDependent
end
