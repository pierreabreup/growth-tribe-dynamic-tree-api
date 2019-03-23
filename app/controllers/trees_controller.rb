class TreesController < ApplicationController
  def index
    render json: Tree.order('id desc')
  end
end
