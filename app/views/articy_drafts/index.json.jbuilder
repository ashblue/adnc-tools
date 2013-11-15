json.array!(@articy_drafts) do |articy_draft|
  json.extract! articy_draft, :ref
  json.url articy_draft_url(articy_draft, format: :json)
end
