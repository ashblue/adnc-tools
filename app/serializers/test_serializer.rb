class TestSerializer < EmberSerializer
  attributes :id, :name

  def id
    object._id.to_s
  end
end
