AdncTools.NodeBasesRoute = Ember.Route.extend
  model: ->
    @get('store').findAll 'node/base'