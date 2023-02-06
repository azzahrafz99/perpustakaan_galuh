class RenameBookCountToStock < ActiveRecord::Migration[6.1]
  def change
    rename_column :books, :book_count, :stock
  end
end
