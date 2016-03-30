class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :room_name
      t.string :buildings
      t.integer :capacity
      t.timestamps null: false
    end
  end
end
