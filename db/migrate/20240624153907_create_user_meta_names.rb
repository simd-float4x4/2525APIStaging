class CreateUserMetaNames < ActiveRecord::Migration[7.1]
  def change
    create_table :user_meta_names do |t|
      t.integer :userId, null: false
      t.string :userMetaName

      t.timestamps
    end
    # インデックスを貼りたい
    add_foreign_key :user_meta_names, :users, column: :userId, primary_key: :userId
    add_index :user_meta_names, :userId 
  end
end
