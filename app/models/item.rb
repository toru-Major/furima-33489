class Item < ApplicationRecord

  with_options presence: true do
    validates :name
    validates :detail
    validates :image
    validates :price, numericality: {greater_than: 300, less_than: 9999999}, format: {with: /\A[0-9]+\z/}
  end
  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :days_to_ship_id 
  end

  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :days_to_ship
end