// For more information see: http://emberjs.com/guides/routing/

AdncTools.Router.map(function () {
    this.resource('tests', function () {
        this.resource('test', { path: ':test_id' })
    });
});


