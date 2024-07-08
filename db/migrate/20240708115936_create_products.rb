class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price, precision: 12, scale: 4, default: "0.0", null: false
      t.decimal :tax, precision: 12, scale: 4
      t.boolean :tax_applicable
      t.string :barcode
      t.text :description1
      t.text :description2
      t.text :description3
      t.text :description4
      t.boolean :published
      t.decimal :compare_at_price, precision: 12, scale: 4
      t.decimal :unit_price, precision: 12, scale: 4
      t.decimal :cost_per_item, precision: 12, scale: 4
      t.integer :category, default: 0
      t.string :status, default: "offline"
      t.boolean :show_description_2, default: false
      t.boolean :show_description_3, default: false
      t.boolean :show_description_4, default: false
      t.decimal :discount, precision: 12, scale: 4

      t.timestamps
    end
  end
end
