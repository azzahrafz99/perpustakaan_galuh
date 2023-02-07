class AddExpiredAtToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :expired_at, :datetime
  end
end
