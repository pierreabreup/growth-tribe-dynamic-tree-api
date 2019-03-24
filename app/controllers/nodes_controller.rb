class NodesController < ApplicationController
  def index
    render json: Node.where(tree_id: params[:tree_id]), each_serializer: NodesSerializer
  end

  def show
    render json: Node.where(tree_id: params[:tree_id], id: params[:id]).first
  end

end
