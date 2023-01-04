class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :restaurant
      t.string :name
      t.string :address
      t.integer :contact

      t.timestamps
    end
  end
end
