class RemoveColumnStatusOnTransactions < ActiveRecord::Migration[6.1]
  def change
    remove_column :transactions, :status
  end
end
