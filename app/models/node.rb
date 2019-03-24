class Node < ApplicationRecord
  belongs_to :tree
  belongs_to :parent, foreign_key: :parent_id, class_name: 'Node', optional: true
  has_many :children, foreign_key: :parent_id, class_name: 'Node'
end
