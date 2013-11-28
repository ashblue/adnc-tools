AdncTools.TestsRoute = Ember.Route.extend({
    model: function() {
        return EmberTester.Post.find();
    }
});