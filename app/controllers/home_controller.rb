class HomeController < ApplicationController
  def index
    @articy_draft = ArticyDraft.new
    @articy_drafts = ArticyDraft.all.sort_by { |d| d[:created_at] }.reverse

    @file_name = FileName.new
    @file_names = FileName.all.sort_by { |f| f.name }

    @profile = Profile.new
    @profiles = Profile.all.sort_by { |p| p.name }.reverse

    @setting = Setting.first
  end
end