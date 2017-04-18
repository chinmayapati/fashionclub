class CreateAddIndexToUsersPhoneEmails < ActiveRecord::Migration
  def change
    add_index :users, :email, unique: true
    add_index :users, :phone, unique: true
  end
end
