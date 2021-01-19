class Item < ApplicationRecord
  with_options presence: true do
    validates :name
    validates :detail
    validates :image
    validates :price, numericality: { greater_than: 299, less_than: 9_999_999 }, format: { with: /\A[0-9]+\z/ }

    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :condition_id
      validates :shipping_fee_id
      validates :prefecture_id
      validates :days_to_ship_id
    end
  end

  belongs_to :user
  has_one :order
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :days_to_ship
end
