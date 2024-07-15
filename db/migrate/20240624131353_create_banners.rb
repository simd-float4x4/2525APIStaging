class CreateBanners < ActiveRecord::Migration[7.1]
  def change
    create_table :banners do |t|
      t.string :imageTitle
      t.integer :imageSortNumber
      t.boolean :hasPublished
      t.string :imageURL
      t.string :transitionURL
     
      t.timestamps
    end
  end
end