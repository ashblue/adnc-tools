json.array!(@node_bases) do |node_basis|
  json.extract! node_basis, :xcode
  json.url node_basis_url(node_basis, format: :json)
end
