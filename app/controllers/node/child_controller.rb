class Node::ChildController < ApplicationController
  def index

  end

  def show

  end

  def destroy
    @child = Node::Child.find(params[:id])
    @child.destroy
  end
end
