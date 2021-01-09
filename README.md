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
| birthyear_id | integer | null: false |
| birthmonth_id | integer | null:false |
| birthday_id | integer | null: false |

### Association

- has_many :items 

## items テーブル

| Column | Type | Options |
| --- | --- | --- |
| name | string | null: false |
| detail | text | null: false |
| price | integer | null: false |
| user_id | references | null: false, foreign_key: true |
| category_id | integer | null: false |
| condition_id | integer | null: false |
| shipping_fee_id | integer | null: false |
| shipping_source_id | integer | null: false |
| days_to_ship_id | integer | null: false |

### Association

- belongs_to : user

## purchase_histories テーブル

| Column | Type | Options |
| --- | --- | --- |
| user_id | references | null:false, foreign_key: true |
| item_id | references | null:false, foreign_key: true |

### Association

- has_one :address

## addresses テーブル

| Column | Type | Options |
| --- | --- | --- |
| postal_code | string | null: false |
| prefecture_id | integer | null: false |
| city | string | null: false |
| block | string | null: false |
| building | string |  |
| phone | integer | null: false |

### Association

- belongs_to :purchase_history
