FactoryBot.define do
  factory :item_order do
    postal_code { '000-1111'}
    prefecture { Faker::Number.between(from: 2, to: 48) }
    city { 'テスト市' }
    block { 'テスト町２−３' }
    building { 'テストビル' }
    phone { '00011112222' }
  end
end
