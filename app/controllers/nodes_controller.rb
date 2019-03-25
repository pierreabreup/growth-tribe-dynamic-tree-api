class NodesController < ApplicationController
  before_action :raise_tree_not_found
  before_action :find_node, except: [:index]

  def index
    render json: Node.where(tree_id: params[:tree_id]), each_serializer: NodesSerializer
  end

  def show
    render json: Node.all_descendants(Node.where(tree_id: params[:tree_id], id: params[:id])).first
  end

  def children_ids
    render json: Node.all_descendants_sql_by_node(@node).pluck(:id)
  end

  def parents_ids
    render json: Node.all_ancestors_sql_by_node(@node).pluck(:id)
  end

  private

  def raise_tree_not_found
    Tree.find(params[:tree_id])
  end

  def find_node
    @node = Node.find_by_tree_id_and_id(params[:tree_id],params[:id])
    if @node.nil?
      raise ActiveRecord::RecordNotFound.new("Couldn't find Node with 'id'=#{params[:id]} for 'tree id'=#{params[:tree_id]}")
    end
  end

end
