class ArticyDraftsController < ApplicationController
  before_action :set_articy_draft, only: [:show, :edit, :update, :destroy]

  # GET /articy_drafts
  # GET /articy_drafts.json
  def index
    @articy_drafts = ArticyDraft.all
  end

  # GET /articy_drafts/1
  # GET /articy_drafts/1.json
  def show
  end

  # GET /articy_drafts/new
  def new
    @articy_draft = ArticyDraft.new
  end

  # GET /articy_drafts/1/edit
  def edit
  end

  # POST /articy_drafts
  # POST /articy_drafts.json
  def create
    @articy_draft = ArticyDraft.new
    @dialogue = Dialogue.new

    file = params[:articy_draft][:file]
    file_name = @articy_draft.id.to_s + '.xml'

    if file.content_type == 'text/xml'
      # @TODO Dump files into something like paperclip, not in root
      File.open(File.join((Rails.root + AppConstants::ARTICY_DRAFT_DIR), file_name), 'wb') do |f|
        f.write(file.read)
      end

      @articy_draft.ref = file_name
    end

    respond_to do |format|
      if @articy_draft.save
        @dialogue.articy_draft = @articy_draft
        @dialogue.save
        format.html { redirect_to root_path, notice: 'Articy Draft XML was successfully created.' }
        format.json { render action: 'show', status: :created, location: @articy_draft }
      else
        # @TODO Delete created file
        format.html { render action: 'new' }
        format.json { render json: @articy_draft.errors, status: :unprocessable_entity }
      end
    end
  end

  # @TODO Delete after clearing out docs
  def upload
    file = params[:file]
    ap File.ftype(file)

    # Dialogue model requires has_one articy_draft, timestamps
    # articy_draft has_one dialogue
    # Show will contain processing to output dialogue boxes by:
      # Grab all dialogue nodes
      # Identify choice groups
      # Possibly group adjacent choice dialogues and create special choice ids
      # Maybe tag nodes that lead to choices
      # To grab or not to grab dialogue in-betweens
    # Ability to scroll through all dialogues with dropdowns (JavaScript collapse)
    # Quick travel by clicking node id
    # Special view for outputting XML nodes as HTML
    # Export JSON script button
      # Exports .js file with all dialogue nodes and added groups
      # Maybe add header and footer for ImpactJS for immediate inclusion (make reusable)
  end

  # PATCH/PUT /articy_drafts/1
  # PATCH/PUT /articy_drafts/1.json
  def update
    respond_to do |format|
      if @articy_draft.update(articy_draft_params)
        format.html { redirect_to @articy_draft, notice: 'Articy draft was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @articy_draft.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articy_drafts/1
  # DELETE /articy_drafts/1.json
  def destroy
    @articy_draft.destroy
    respond_to do |format|
      format.html { redirect_to articy_drafts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_articy_draft
      @articy_draft = ArticyDraft.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def articy_draft_params
      params.require(:articy_draft).permit(:ref)
    end
end
