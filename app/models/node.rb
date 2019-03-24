class Node < ApplicationRecord
  belongs_to :tree
  belongs_to :parent, foreign_key: :parent_id, class_name: 'Node', optional: true

  has_many :children, foreign_key: :parent_id, class_name: 'Node'

  before_create :assign_depth

  class << self
    #fetch descendants using preloader. Useful when the data is read by nested/recursive loop
    def all_descendants(arel)
      arel.includes(children_preload_hash)
    end

    def children_preload_hash
      self.order('depth desc')
      .limit(1)
      .pluck(:depth)
      .first
      .times
      .inject(:children) { |h| { children: h } }
    end

    #fetch descendants using raw sql. Useful when the data is read by linear loop
    def all_descendants_sql_by_node(node)
      column_names_initial_select   = column_names.join(',')
      column_names_recursive_select = column_names.map { |c| 't.'+ c }.join(',')

      sql = "
          WITH RECURSIVE fulltree(#{column_names_initial_select},path) AS
          (
            SELECT #{column_names_initial_select}, name||'' as path from nodes where parent_id = #{node.id}
              UNION ALL
            SELECT #{column_names_recursive_select}, ft.path||' / '||t.name as path
              from nodes t, fulltree ft where t.parent_id = ft.id
          )
          SELECT * from fulltree order by id
    def all_ancestors_sql_by_node(node)
      column_names_initial_select   = column_names.join(',')
      column_names_recursive_select = column_names.map { |c| 't.'+ c }.join(',')

      sql = "
          WITH RECURSIVE walk_tree_to_root(#{column_names_initial_select}) AS
          (
            SELECT #{column_names_initial_select} FROM nodes WHERE id = #{node.id}
              UNION ALL
            SELECT #{column_names_recursive_select}
              FROM nodes t, walk_tree_to_root ft WHERE t.id = ft.parent_id and ft.depth != 0
          )
          SELECT * FROM walk_tree_to_root WHERE id != #{node.id} ORDER BY id desc
        "

      find_by_sql(sql)
    end

  end

  private

  def assign_depth
    self.depth = (parent.present? ? parent.depth + 1 : 0)
  end

end
