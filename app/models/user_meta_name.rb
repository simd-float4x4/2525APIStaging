class UserMetaName < ApplicationRecord
    belongs_to :user, primary_key: :userId, foreign_key: :userId, optional: true
end

# 親
# has_many :子のテーブル名, primary_key: :親の主キー, foreign_key: :親の主キー

# 子
# belongs_to :親のテーブル名, primary_key:  :親の主キー, foreign_key: :親の主キー,