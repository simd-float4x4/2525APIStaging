class CreatePlatformLists < ActiveRecord::Migration[7.1]
  def change
    create_table :platform_lists do |t|

      t.timestamps
    end
  end
end
