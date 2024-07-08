class Variant < ApplicationRecord
  belongs_to :product

  enum option: {size: 0, color: 1, material: 2, style: 3}, _prefix: :option

  scope :order_by_created_at, ->{ order(created_at: :asc) }
end
