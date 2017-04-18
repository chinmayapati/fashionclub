class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :fname
      t.string :lname
      t.string :email
      t.string :addr_one
      t.string :addr_two
      t.string :city
      t.integer :zip
      t.string :country
      t.integer :phone, limit: 8

      t.timestamps null: false
    end
  end
end
