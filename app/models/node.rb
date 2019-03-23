class Node < ApplicationRecord
  belongs_to :tree
  has_many :children, foreign_key: :parent_id, class_name: 'Node'
end
