class RenameBookCodeToIsbn < ActiveRecord::Migration[6.1]
  def change
    rename_column :books, :book_code, :isbn
  end
end
