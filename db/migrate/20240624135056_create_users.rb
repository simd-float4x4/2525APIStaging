class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: false do |t|
      t.primary_key :userId
      t.string :hashtag
      t.string :name
      
      t.timestamps
    end
    add_index :users, :userId, unique: true
    add_index :users, :hashtag, unique: true
  end
end


#　親
#　add_index :親のテーブル名, :親キー, unique: true

#　子
#　add_foreign_key :子のテーブル名, :親のテーブル名, column: :親キー, primary_key: :親キー
#　add_index :子のテーブル名, :親キー
