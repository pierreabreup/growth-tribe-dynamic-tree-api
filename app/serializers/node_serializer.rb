class NodeSerializer < ActiveModel::Serializer
  attributes :id, :children

  #UNFORTUNATELY has_many ASSOCIATION DOESN'T WORK IN DEEP LEVEL (active_model_serializer notorious bug)
  def children
    nested_children(object.children)
  end

  private

  def nested_children(chd)
    chd.map {|c| {id: c.id, children: nested_children(c.children) } }
  end
end
