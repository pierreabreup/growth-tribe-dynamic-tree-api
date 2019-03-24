class Node < ApplicationRecord
  belongs_to :tree
  belongs_to :parent, foreign_key: :parent_id, class_name: 'Node', optional: true

  has_many :children, foreign_key: :parent_id, class_name: 'Node', dependent: :destroy

  validates_presence_of :name, :tree_id

  before_create :assign_depth

  class << self
    #fetch descendants using preloader. Useful when the data is read by nested/recursive loop
    def all_descendants(arel)
      arel.includes(children_preload_hash)
    end

    def children_preload_hash
      (
        self.order('depth desc')
        .limit(1)
        .pluck(:depth)
        .first || 0
      )
      .times
      .inject(:children) { |h| { children: h } }
    end

    #fetch descendants using raw sql. Useful when the data is read by linear loop
    def all_descendants_sql_by_node(node)
      column_names_initial_select   = column_names.join(',')
      column_names_recursive_select = column_names.map { |c| 't.'+ c }.join(',')

      sql = "
          WITH RECURSIVE walk_tree_to_deep(#{column_names_initial_select}) AS
          (
            SELECT #{column_names_initial_select} FROM nodes WHERE parent_id = #{node.id}
              UNION ALL
            SELECT #{column_names_recursive_select}
              FROM nodes t, walk_tree_to_deep ft WHERE t.parent_id = ft.id
          )
          SELECT * FROM walk_tree_to_deep ORDER BY id
        "

      find_by_sql(sql)
    end

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
