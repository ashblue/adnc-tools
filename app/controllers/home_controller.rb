class HomeController < ApplicationController
  def index
    @articy_draft = ArticyDraft.new
  end
end

# JS workflow
# Pull up conversation by id
# Check what kind of conversation has been loaded