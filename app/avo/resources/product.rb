# frozen_string_literal: true

module Avo
  module Resources
    class Product < Avo::BaseResource

      self.title = :title
      self.includes = []
      self.after_create_path = :edit
      self.after_update_path = :edit
      self.extra_params = [variants_attributes: [:id, :title, :price, :available, :on_hand, :sku, :barcode, :position,
                                                 :options, :cost_currency, :avatar, :_destroy, :archived]]

      def fields
        main_panel do
          field :id, as: :id
          field :title, as: :text, required: true
          product_sidebar
        end

        tool Avo::ResourceTools::ProductVariants, show_on: [:edit, :show], hide_on: [:index]
      end

      def product_sidebar
        sidebar do
          tool Avo::ResourceTools::CatalogueOrganization, show_on: [:edit]
        end
      end
    end
  end
end
