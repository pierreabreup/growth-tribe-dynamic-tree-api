class NodesController < ApplicationController
  def index
    render json: Node.where(tree_id: params[:tree_id]), each_serializer: NodesSerializer
  end

  def show
    render json: Node.all_descendants(Node.where(tree_id: params[:tree_id], id: params[:id])).first
  end

  def children_ids
    render json: Node.all_descendants_sql_by_node(Node.where(tree_id: params[:tree_id], id: params[:id]).first).pluck(:id)
  end

end
