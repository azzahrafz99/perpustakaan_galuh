class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true

  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :transactions
  # rubocop:enable Rails/HasManyOrHasOneDependent

  after_create :assign_default_role

  def assign_default_role
    add_role(:user) if roles.blank?
  end

  def admin?
    has_role?(:admin)
  end
end
