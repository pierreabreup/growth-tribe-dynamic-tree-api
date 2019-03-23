class CreateNodes < ActiveRecord::Migration[5.2]
  def change
    create_table :nodes do |t|
      t.string :name, null: false
      t.integer :parent_id, default: 0
      t.belongs_to :tree, null: false

      t.timestamps
    end
  end
end
