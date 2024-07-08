class Product < ApplicationRecord
  has_one :catalogue_organization, dependent: :destroy
  accepts_nested_attributes_for :catalogue_organization, allow_destroy: true
  has_many :variants, dependent: :destroy
  accepts_nested_attributes_for :variants, allow_destroy: true
end
