class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :detail
    validates :price, numericality: {greater_than: 300,
                                     less_than: 9999999},
                      format: {with: \d}
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :days_to_ship_id
  end
end
