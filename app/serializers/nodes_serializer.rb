class NodesSerializer < ActiveModel::Serializer
  attributes :id

  has_many :children
end
