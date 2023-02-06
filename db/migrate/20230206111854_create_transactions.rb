class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.date       :borrow_date
      t.date       :return_date
      t.integer    :period
      t.references :user
      t.references :book
      t.integer    :status
      t.timestamps
    end
  end
end
