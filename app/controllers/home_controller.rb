class HomeController < ApplicationController
  def index
    @articy_draft = ArticyDraft.new
    @articy_drafts = ArticyDraft.all.sort_by { |d| d[:created_at] }.reverse

    @profile = Profile.new
    @profiles = Profile.all.sort_by { |d| d[:created_at] }.reverse
  end
end