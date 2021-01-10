require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'すべての情報が存在すれば登録できること' do
      expect(@user).to be_valid
    end

    it 'nicknameが空では登録できないこと' do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it '重複したemailが存在する場合登録できないこと' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'emailに@が無ければ存在できないこと' do
      @user.email = 'testtest'
      @user.email = 'testtest'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが空では登録できないこと' do
      @user.password = nil
      @user.password_confirmation = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank", 'Password is invalid')
    end

    it 'passwordが6文字以上であれば登録できること' do
      @user.password = '11111aaaa'
      @user.password_confirmation = '11111aaaa'
      @user.valid?
      expect(@user).to be_valid
    end

    it 'passwordが5文字以下であれば登録できないこと' do
      @user.password = '111a'
      @user.password_confirmation = '111a'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordが半角英数字混合でなければ登録できないこと' do
      @user.password = 'aaaaaa'
      @user.password_confirmation = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end

    it 'passwordは確認用も含めて2回入力されて無ければ登録できないこと' do
      @user.password = nil
      @user.password_confirmation = 'aaaatest'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank", 'Password is invalid',
                                                    "Password confirmation doesn't match Password")
    end

    it 'passwordとpassword_confirmationが不一致では登録できないこと' do
      @user.password = '111aaa'
      @user.password_confirmation = '222aaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'ユーザー名は姓が無ければ登録できないこと' do
      @user.last_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'ユーザー名は名が無けれ登録できないこと' do
      @user.first_name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'ユーザー名は全角でないと登録できないこと' do
      @user.last_name = 'ｱｶ'
      @user.first_name = 'ﾃｽ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid', 'First name is invalid')
    end

    it 'ユーザー名の名字と名前のフリガナ（カタカナ）がなければ登録できないこと' do
      @user.last_name_kana = nil
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank",
                                                    'Last name kana is invalid',
                                                    "First name kana can't be blank",
                                                    'First name kana is invalid')
    end

    it '生年月日がなければ登録できないこと' do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
