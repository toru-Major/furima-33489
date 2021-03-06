class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do
    validates :nickname
    validates :email, uniqueness: { case_sensitive: false }
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
    validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥々]/ }
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥々]/ }
    validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ }
    validates :birthday
  end

  has_many :orders, dependent: :destroy
  has_many :items,  dependent: :destroy
end
