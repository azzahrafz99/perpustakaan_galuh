class TransactionPolicy
  attr_reader :user, :transaction

  def initialize(user, transaction)
    @user = user
    @transaction = transaction
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end
