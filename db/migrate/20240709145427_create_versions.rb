class CreateVersions < ActiveRecord::Migration[7.1]
  def change
    create_table :versions do |t|
      t.string :version
      t.string :content

      t.timestamps
    end
  end
end
