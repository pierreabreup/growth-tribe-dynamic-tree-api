class CreateTreeNodesWorker
  include Sidekiq::Worker

  def perform(tree_id)
    tree = Tree.find(tree_id)
    create_nodes(ActiveSupport::JSON.decode(tree.json_data)['child'], tree_id)
  rescue ActiveRecord::RecordNotFound => e
    #maybe record this event on Graylog for further investigation
    puts 'really ?!'
  rescue Exception => e
    puts 'Are you kidding me ?'
    #send this event to Sentry (Yes, Sentry must be configured before)
  end


  private

  def create_nodes(hsh_nodes, tree_id, parent_id = 0)
    hsh_nodes.each do |hsh_node|
      node = Node.create!(name: hsh_node['id'], parent_id: parent_id, tree_id: tree_id)
      if hsh_node['child'].any?
        create_nodes(hsh_node['child'], tree_id, node.id)
      end
    end
  end
end
