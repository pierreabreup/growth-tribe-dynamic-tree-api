class AddDepthToNodes < ActiveRecord::Migration[5.2]
  def change
    add_column :nodes, :depth, :integer, default: 0
    add_index :nodes, :depth
  end
end
