class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :phone, limit: 8
      t.string :password
      t.string :avatar

      t.timestamps null: false
    end
  end
end
