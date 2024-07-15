class User < ApplicationRecord
    validates :hashtag, uniqueness: true
    validates :hashtag, numericality: {only_integer: true}

    self.primary_key = 'userId'
    has_many :user_meta_names, primary_key: :userId, foreign_key: 'userId', class_name: 'UserMetaName'
    has_many :user_platforms, primary_key: :userId, foreign_key: 'userId', class_name: 'UserPlatform'

    accepts_nested_attributes_for :user_meta_names, allow_destroy: true
    accepts_nested_attributes_for :user_platforms, allow_destroy: true
end