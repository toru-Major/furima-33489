require 'rails_helper'

RSpec.describe ItemOrder, type: :model do
  before do
    @item_order = FactoryBot.build(:item_order)
  end
  describe '商品購入' do
    context '購入できるとき'
    it '全ての情報を正しく入力すれば保存できる' do
      expect(@item_order).to be_valid
    end
  end

  context '購入できないとき' do
    it 'tokenがないと購入できない' do
      @item_order.token = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Token can't be blank")
    end

    it 'user_idがないと購入できない' do
      @item_order.user_id = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("User can't be blank")
    end

    it 'item_idがないと購入できない' do
      @item_order.item_id = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Item can't be blank")
    end

    it '郵便番号がないと購入できない' do
      @item_order.postal_code = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Postal code can't be blank")
    end

    it '郵便番号にハイフンがないと購入できない' do
      @item_order.postal_code = '0001111'
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include('Postal code is invalid')
    end

    it '都道府県がないと購入できない' do
      @item_order.prefecture = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Prefecture can't be blank")
    end

    it '都道府県のidが１では登録できない' do
      @item_order.prefecture = 1
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Prefecture must be other than 1")
    end

    it '市区町村がないと購入できない' do
      @item_order.city = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("City can't be blank")
    end

    it '番地がないと購入できない' do
      @item_order.block = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Block can't be blank")
    end

    it '電話番号がないと購入できない' do
      @item_order.phone = nil
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Phone can't be blank")
    end

    it '電話番号にハイフンがあれば購入できない' do
      @item_order.phone = '000-1111-2222'
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include('Phone is invalid')
    end

    it '電話番号が12桁以上であると保存できない' do
      @item_order.phone = '111122223333'
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include('Phone is invalid')
    end

    it '電話番号が英数混合では登録できないこと' do
      @item_order.phone = '000aaaabbbb'
      @item_order.valid?
      expect(@item_order.errors.full_messages).to include("Phone is invalid")
    end
  end
end
