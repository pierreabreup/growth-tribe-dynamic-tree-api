class TreeSerializer < ActiveModel::Serializer
  attributes :id

  has_many :nodes

  def nodes
    Node.all_descendants(object.nodes.where(parent_id: 0))
  end
end
