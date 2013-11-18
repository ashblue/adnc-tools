class HomeController < ApplicationController
  def index
    @articy_draft = ArticyDraft.new
    @articy_drafts = ArticyDraft.all.sort_by { |d| d[:created_at] }.reverse
  end
end

# JS workflow
# Pull up conversation by id
# Check what kind of conversation has been loaded