class CreateCatalogueOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :catalogue_organizations do |t|

      t.string :vendor, null: false
      t.string :product_tags
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
