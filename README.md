# README

# テーブル設計

## users　テーブル

| Column | Type | Options |
| --- | --- | --- |
| nickname | string | null: false |
| email | string | null: false |
| last_name | string | null: false |
| first_name | string | null: false |
| last_name_kana | string | null: false |
| first_name_kana | string | null: false |
| birth_date | date | null: false |

### Association

- has_many :items 

## items　テーブル

| Column | Type | Options |
| --- | --- | --- |
| image | string | null: false |
| name | text | null: false |
| detail | text | null: false |
| category | string | null: false |
| condition | string | null: false |
| shipping_fee | string | null: false |
| shipping_source | string | null: false |
| days_to_ship | integer | null: false |
| price | integer | null: false |
| user | references | null: false, foreign_key: true |

### Association

- belongs_to : user