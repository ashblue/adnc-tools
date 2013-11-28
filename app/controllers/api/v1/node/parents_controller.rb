class Api::V1::Node::ParentsController < ApplicationController
  respond_to :json

  def index
    respond_with Node::Parent.all
  end

  def show
    respond_with Node::Parent.find(params[:id])
  end

  def update
    @node_parent = Node::Parent.find(params[:id])


    respond_to do |f|
      if @node_parent.update_attributes(node_parent_params)
        f.json { render :json => @node_parent }
      else
        f.json { render :json => @node_parent.errors }
      end
    end
  end

  private

  def node_parent_params
    params.require(:node_parent).permit(:xpath)
  end
end
