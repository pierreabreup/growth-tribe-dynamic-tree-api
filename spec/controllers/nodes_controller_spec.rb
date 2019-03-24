require "rails_helper"

RSpec.describe NodesController, :type => :controller do
  let!(:tree) { create(:tree) }
  let!(:node_one) { create(:node, tree_id: tree.id) }
  let!(:node_two) { create(:node, tree_id: tree.id) }
  let!(:sub_node_one) { create(:node, tree_id: tree.id, parent_id: node_one.id, depth: 1) }
  let!(:sub_sub_node_one) { create(:node, tree_id: tree.id, parent_id: sub_node_one.id, depth: 2) }

  context 'when GET /trees/:id/nodes' do
    context 'and there is nodes' do
      before {
        get :index, params: { tree_id: tree.id }
      }

      it { is_expected.to respond_with 200 }
      it { expect(json_data.size).to eq(4) }
      it { expect(json_data).to eq([{'id' => node_one.id}, {'id' => node_two.id}, {'id' => sub_node_one.id},  {'id' => sub_sub_node_one.id} ]) }
    end
  end

  context 'when GET /trees/:id/nodes/:id' do
    before {
      get :show, params: { tree_id: tree.id, id: node_one.id }
    }

    it { is_expected.to respond_with 200 }
    it { expect(json_data['id']).to eq(node_one.id) }
    it {
      expected_children = [
        {
          'id' => sub_node_one.id,
          'children' => [
            {
              'id' => sub_sub_node_one.id,
              'children' => []
            }
          ]
        }
      ]
      expect(json_data['children']).to eq(expected_children)
    }
  end

  context 'when GET /trees/:id/nodes/:id/children_ids' do
    before {
      get :children_ids, params: { tree_id: tree.id, id: node_one.id }
    }

    it { is_expected.to respond_with 200 }
    it { expect(json_data).to eq([sub_node_one.id, sub_sub_node_one.id]) }
  end

  context 'when GET /trees/:id/nodes/:id/parents_ids' do
    before {
      get :parents_ids, params: { tree_id: tree.id, id: sub_sub_node_one.id }
    }

    it { is_expected.to respond_with 200 }
    it { expect(json_data).to eq([sub_node_one.id, node_one.id]) }
  end

end
