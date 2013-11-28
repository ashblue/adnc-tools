class Api::V1::TestsController < ApplicationController
  respond_to :json

  def index
    respond_with Test.all
  end

  def show
    respond_with Test.find(params[:id])
  end

  private

  def entry_params
    params.require(:test).permit(:name)
  end
end
