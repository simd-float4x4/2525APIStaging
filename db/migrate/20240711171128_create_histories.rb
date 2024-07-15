class CreateHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :histories do |t|

      t.string :ipAddress
      t.string :browser
      t.string :os
      t.string :device
      t.string :user_agent

      t.timestamps
    end
  end
end
