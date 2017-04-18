class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.integer :phone, limit: 8
      t.string :address_one
      t.string :address_two
      t.string :city
      t.integer :zipcode
      t.string :country
      t.text :additional

      t.timestamps null: false
    end
  end
end
