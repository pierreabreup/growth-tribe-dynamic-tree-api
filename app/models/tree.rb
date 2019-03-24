class Tree < ApplicationRecord
  has_many :nodes, dependent: :destroy

  validates_presence_of :json_data
end
