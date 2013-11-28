//AdncTools.TestsRoute = Ember.Route.extend
//  model: ->
//    @get('store').findAll 'test'
//
AdncTools.TestsRoute = Ember.Route.extend({
  model: function () {
      console.log(this.get('store').find('test'));
    return this.get('store').findAll('test');
  }
});