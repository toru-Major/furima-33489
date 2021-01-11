FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { 'test1234TEST' }
    password_confirmation { password }
    last_name             { '寺原' }
    first_name            { '徹' }
    last_name_kana        { 'テスト' }
    first_name_kana       { 'タロウ' }
    birthday              { Faker::Date.between(from: '2014-09-23', to: '2014-09-25') }
  end
end
