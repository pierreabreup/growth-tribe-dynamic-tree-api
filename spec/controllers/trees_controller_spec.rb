require "rails_helper"

RSpec.describe TreesController, :type => :controller do
  context 'when GET /' do
    let!(:tree) { create(:tree) }

    before {
      get :index
    }

    it { is_expected.to respond_with 200 }
    it { expect(json_data.size).to eq(1) }
    it { expect(json_data.first['id']).to eq(tree.id) }
  end

  context 'when GET /trees/:id' do
    let!(:tree) { create(:tree) }

    context "and tree is found with no nodes" do
      before {
        get :show, params: { id: tree }
      }

      it { is_expected.to respond_with 200 }
      it { expect(json_data['id']).to eq(tree.id) }
    end


    context "and tree is found with nodes" do
      it 'nodes tree is valid' do
        node_one = create(:node, tree_id: tree.id)
        node_two = create(:node, tree_id: tree.id)
        sub_node_one = create(:node, tree_id: tree.id, parent_id: node_one.id, depth: 1)

        get :show, params: { id: tree }

        expected_tree_nodes = [
          {
            'id' => node_one.id,
            'children' => [
              {
                'id' => sub_node_one.id,
                'children' => []
              }
            ]
          },
          {
            'id' => node_two.id,
            'children' => []
          }
        ]

        expect(json_data['nodes']).to eq(expected_tree_nodes)
      end
    end
  end
end
