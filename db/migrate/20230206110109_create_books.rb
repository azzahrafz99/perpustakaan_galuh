class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string  :title
      t.text    :summary
      t.string  :book_code, index: { unique: true }
      t.string  :author
      t.string  :language
      t.string  :publisher
      t.integer :book_count, default: 0
      t.timestamps
    end
  end
end
