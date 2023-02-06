class RenameBorrowDateToLoanDate < ActiveRecord::Migration[6.1]
  def change
    rename_column :transactions, :borrow_date, :loan_date
  end
end
