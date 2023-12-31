class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.text :address
      t.string :phone
      t.integer :user_id
      t.integer :order_amount
      t.date :order_on

      t.timestamps
    end
  end
end
