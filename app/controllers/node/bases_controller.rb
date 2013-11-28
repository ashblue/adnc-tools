class Node::BasesController < ApplicationController
  before_action :set_node_basis, only: [:show, :edit, :update, :destroy]

  # GET /node/bases
  # GET /node/bases.json
  def index
    @node_bases = Node::Base.all
  end

  # GET /node/bases/1
  # GET /node/bases/1.json
  def show
  end

  # GET /node/bases/new
  def new
    @node_basis = Node::Base.new
  end

  # GET /node/bases/1/edit
  def edit
  end

  # POST /node/bases
  # POST /node/bases.json
  def create
    @node_basis = Node::Base.new(node_basis_params)

    respond_to do |format|
      if @node_basis.save
        format.html { redirect_to @node_basis, notice: 'Base was successfully created.' }
        format.json { render action: 'show', status: :created, location: @node_basis }
      else
        format.html { render action: 'new' }
        format.json { render json: @node_basis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /node/bases/1
  # PATCH/PUT /node/bases/1.json
  def update
    respond_to do |format|
      if @node_basis.update(node_basis_params)
        format.html { redirect_to @node_basis, notice: 'Base was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @node_basis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /node/bases/1
  # DELETE /node/bases/1.json
  def destroy
    @node_basis.destroy
    respond_to do |format|
      format.html { redirect_to node_bases_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node_basis
      @node_basis = Node::Base.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def node_basis_params
      params.require(:node_base).permit(:xcode)
    end
end
