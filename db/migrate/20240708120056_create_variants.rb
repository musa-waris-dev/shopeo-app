class CreateVariants < ActiveRecord::Migration[7.0]
  def change
    create_table :variants do |t|

      t.decimal :price, precision: 10, scale: 2
      t.decimal :cost_price, precision: 10, scale: 2
      t.integer :position
      t.boolean :track_inventory
      t.string :sku
      t.integer :cost_currency
      t.json :options
      t.integer :product_id
      t.string :title
      t.decimal :discount, precision: 10, scale: 2
      t.integer :option, default: 0
      t.string :option_value
      t.integer :available
      t.integer :on_hand
      t.string :barcode
      t.boolean :archived, default: false
      t.timestamps
    end
  end
end
