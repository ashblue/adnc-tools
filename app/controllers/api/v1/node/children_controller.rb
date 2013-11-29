class Api::V1::Node::ChildrenController < ApplicationController
  respond_to :json

  def index
    respond_with Node::Child.all
  end

  def show
    respond_with Node::Child.find(params[:id])
  end

  def update
    @node_child = Node::Child.find(params[:id])

    respond_to do |f|
      if @node_child.update_attributes(node_child_params)
        f.json { render :json => @node_child }
      else
        f.json { render :json => @node_child.errors }
      end
    end
  end

  private

  def node_child_params
    params.require(:node_child).permit(:xpath, :return_attr, :helper, :enforce_type)
  end
end
