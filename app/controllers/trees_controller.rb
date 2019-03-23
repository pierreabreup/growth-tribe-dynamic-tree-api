class TreesController < ApplicationController
  def index
    render json: Tree.order('id desc'), each_serializer: TreesSerializer
  end

  def show
    render json: Tree.find(params[:id])
  end
end
