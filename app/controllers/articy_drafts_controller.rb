class ArticyDraftsController < ApplicationController
  require 'zip/zip'
  require 'zip/zipfilesystem'

  before_action :set_articy_draft, only: [:show, :edit, :update, :destroy, :download]

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

    file = params[:articy_draft][:file]
    @articy_draft.xml = file
    @articy_draft.notes = params[:articy_draft][:notes]

    respond_to do |format|
      if @articy_draft.save
        format.html { redirect_to root_path, notice: 'Articy Draft XML was successfully created.' }
        format.json { render action: 'show', status: :created, location: @articy_draft }
      else
        format.html { render action: 'new' }
        format.json { render json: @articy_draft.errors, status: :unprocessable_entity }
      end
    end
  end

  def download
    xml = @articy_draft.file_xml

    # Loop through and create files
    files = []
    settings = Setting.first

    # A Settings object must exist in order to proceed
    if (!settings)
      raise 'A settings object must exist in order to process your export. Please create a settings object at root/settings/new. You can then maintain that object from the home page.'
    end

    FileName.all.each do |f|
      new_file = File.new(f.name + '.' + settings.file_type, 'w')
      results = {}

      # Loop through each profile and combine parent results
      f.profiles.each do |p|
        results = results.merge(p.node_parent.result(xml))
      end

      json_result = results.to_json.to_s.html_safe

      if (settings.wrapper)
        file_text = settings.wrapper
          .gsub('#json', json_result)
          .gsub('#name', f.name)
      else
        file_text = json_result
      end

      new_file.puts file_text

      new_file.close
      files.push(new_file)
    end

    # Write to a location or return a zip file
    if settings and not settings.write_location.empty?
      files.each do |f|
        File.open(settings.write_location + '/' + File.basename(f), 'w') do |t|
          t.write(File.read(f))
        end
      end
    else
      t = Tempfile.new('dump')
      # Give the path of the temp file to the zip outputstream, it won't try to open it as an archive.
      Zip::ZipOutputStream.open(t.path) do |zos|
        files.each do |f|
          zos.put_next_entry(File.basename(f))
          zos.print IO.read(File.path(f))
        end
      end

      send_file t.path, :type => 'application/zip', :disposition => 'attachment', :filename => "dialogues.zip"
      t.close
    end

    files.each do |f|
      File.delete f
    end

    flash[:notice] = 'Files written to ' + settings.write_location
    redirect_to root_path
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
      format.html { redirect_to root_path }
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
      params.require(:articy_draft).permit(:ref, :notes)
    end
end
