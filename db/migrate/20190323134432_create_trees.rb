class CreateTrees < ActiveRecord::Migration[5.2]
  def change
    create_table :trees do |t|
      t.text :json_data, null: false

      t.timestamps
    end
  end
end
