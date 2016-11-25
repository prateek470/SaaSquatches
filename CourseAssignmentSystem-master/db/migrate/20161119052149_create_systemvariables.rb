class CreateSystemvariables < ActiveRecord::Migration
  def change
    create_table :systemvariables do |t|
      t.string :name
      t.string :value
      t.timestamps null: false
    end
  end
end
