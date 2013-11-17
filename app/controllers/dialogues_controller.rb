class DialoguesController < ApplicationController
  before_action :set_dialogue, only: [:show, :edit, :update, :destroy, :download]

  # GET /dialogues
  # GET /dialogues.json
  def index
    @dialogues = Dialogue.all
  end

  # GET /dialogues/1
  # GET /dialogues/1.json
  def show
    xml = @dialogue.articy_draft.file_xml
    @dialogues = xml.xpath('//Dialogue')
  end

  # GET /dialogues/new
  def new
    @dialogue = Dialogue.new
  end

  # GET /dialogues/1/edit
  def edit
  end

  # @TODO Downloads should be accomplished under Articy_Draft controller and done through home page
  # @TODO Maximize re-usability of code / methods and make sure this can be extended to include
  # new models
  # @TODO At some point in the HTML5 app dialogue should walk backwards to verify the first
  # dialogue called is the start of the conversation
  require 'zip/zip'
  require 'zip/zipfilesystem'
  def download
    xml = @dialogue.articy_draft.file_xml
    h_dialogues = {}
    @dialogues = xml.xpath('//Dialogue')

    # @TODO Move these JSON parsers to a to_json method on the models
    # @TODO connectors xpath should only be called once
    @dialogues.each do |d|
      text = d.at_xpath('.//Text/LocalizedString')
      character = d.at_xpath('.//References/Reference/@IdRef')
      connectors = d.xpath('//Connection/Source[@IdRef="' + d['Id'] + '"]').map do |c|
        c.parent.xpath('.//Target').attribute('IdRef').to_s
      end

      h_dialogues[d['Id']] = {
        :text => text.class == NilClass ? '' : text.inner_text,
        :character => character.class == NilClass ? '' : character.inner_text,
        :connections => connectors
      }
    end

    file_dialogues = Tempfile.new(%w(dialogues .json))
    file_dialogues.puts h_dialogues.to_json
    file_dialogues.close

    # @TODO Kind of a stupid way of doing this, put files in an array for better management
    t = Tempfile.new('dump')
    # Give the path of the temp file to the zip outputstream, it won't try to open it as an archive.
    Zip::ZipOutputStream.open(t.path) do |zos|
      #[file_connections, file_dialogues].each do |f|
      #  # Create a new entry with some arbitrary name
      #  zos.put_next_entry(f.basename)
      #  # Add the contents of the file, don't read the stuff linewise if its binary, instead use direct IO
      #  zos.print IO.read(f.basename)
      #end

      zos.put_next_entry('dialogues.json')
      zos.print IO.read(file_dialogues.path)
    end

    send_file t.path, :type => 'application/zip', :disposition => 'attachment', :filename => "dialogues.zip"
    t.close
  end

  # POST /dialogues
  # POST /dialogues.json
  def create
    @dialogue = Dialogue.new(dialogue_params)

    respond_to do |format|
      if @dialogue.save
        format.html { redirect_to @dialogue, notice: 'Dialogue was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dialogue }
      else
        format.html { render action: 'new' }
        format.json { render json: @dialogue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dialogues/1
  # PATCH/PUT /dialogues/1.json
  def update
    respond_to do |format|
      if @dialogue.update(dialogue_params)
        format.html { redirect_to @dialogue, notice: 'Dialogue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dialogue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dialogues/1
  # DELETE /dialogues/1.json
  def destroy
    @dialogue.destroy
    respond_to do |format|
      format.html { redirect_to dialogues_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dialogue
      @dialogue = Dialogue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dialogue_params
      params[:dialogue]
    end
end
