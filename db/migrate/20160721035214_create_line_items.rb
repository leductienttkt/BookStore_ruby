class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :cart_id
      t.book :book
      t.integer :quantity, default: 1
      t.float :price

      t.timestamps null: false
    end
  end
end
