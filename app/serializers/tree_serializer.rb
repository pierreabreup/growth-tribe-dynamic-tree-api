class TreeSerializer < ActiveModel::Serializer
  attributes :id, :nodes

  def nodes
    object.nodes.where(parent_id: 0).map {|n| node_to_hash(n) }
  end

  private

  def node_to_hash(node)
    {
      id: node.id,
      children: node.children.map {|n| node_to_hash(n) }
    }
  end
end
