class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :category
      t.string :subcat
      t.string :name
      t.string :brand
      t.integer :price
      t.integer :discount
      t.string :availability
      t.string :tags
      t.text :brief
      t.text :desc
      t.integer :rating

      t.timestamps null: false
    end
  end
end
