class CreateDonuts < ActiveRecord::Migration[7.1]
  def change
    create_table :donuts do |t|
      t.string :name
      t.string :tokenA
      t.string :tokenB
      t.string :tokenC
      
      t.integer :tokenD

      t.timestamps
    end
  end
end
