class CreateNotices < ActiveRecord::Migration[7.1]
  def change
    create_table :notices do |t|
      t.string :title
      t.string :date
      t.text :body
      t.string :mainCategory
      t.boolean :hasPublished

      t.timestamps
    end
  end
end