# README

# テーブル設計

## users テーブル

| Column | Type | Options |
| --- | --- | --- |
| nickname | string | null: false |
| email | string | null: false |
| encrypted_password | string | null: false |
| last_name | string | null: false |
| first_name | string | null: false |
| last_name_kana | string | null: false |
| first_name_kana | string | null: false |
| birthday | date | null: false |

### Association

- has_many :items 
- has_many :purchase_histories

## items テーブル

| Column | Type | Options |
| --- | --- | --- |
| name | string | null: false |
| detail | text | null: false |
| price | integer | null: false |
| user | references | null: false, foreign_key: true |
| category_id | integer | null: false |
| condition_id | integer | null: false |
| shipping_fee_id | integer | null: false |
| prefecture_id | integer | null: false |
| days_to_ship_id | integer | null: false |

### Association

- belongs_to : user
- has_one :purchase_history

## purchase_histories テーブル

| Column | Type | Options |
| --- | --- | --- |
| user | references | null:false, foreign_key: true |
| item | references | null:false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column | Type | Options |
| --- | --- | --- |
| postal_code | string | null: false |
| prefecture_id | integer | null: false |
| city | string | null: false |
| block | string | null: false |
| building | string |  |
| phone | string | null: false |
| purchase_history | references | null:false, foreign_key: true |

### Association

- belongs_to :purchase_history
