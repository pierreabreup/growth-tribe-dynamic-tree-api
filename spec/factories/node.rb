FactoryBot.define do
  factory :node do
    name { 'node' }
    tree_id { nil }
    depth { 0 }
    parent_id { 0 }
  end
end
