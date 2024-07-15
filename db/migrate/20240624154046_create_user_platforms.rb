class CreateUserPlatforms < ActiveRecord::Migration[7.1]
  def change
    create_table :user_platforms do |t|
      t.integer :userId, null: false
      t.integer :itemId
      t.integer :platformId, null: false
      t.string :platformName, null: false
      t.string :accountUserId
      t.string :accountUserName
      t.string :accountIconImageUrl
      t.string :accountUserUrl
      t.string :accountUserSubText
      t.boolean :hasAccount
      t.boolean :isBroadCasting

      t.timestamps
    end
  end
end

#　親
#　add_index :親のテーブル名, :親キー, unique: true

#　子
#　add_foreign_key :子のテーブル名, :親のテーブル名, column: :親キー, primary_key: :親キー
#　add_index :子のテーブル名, :親キー