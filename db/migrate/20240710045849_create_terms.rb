class CreateTerms < ActiveRecord::Migration[7.1]
  def change
    create_table :terms do |t|
      t.text :version
      t.text :content

      t.timestamps
    end
  end
end
