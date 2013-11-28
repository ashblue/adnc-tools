AdncTools.Router.map(function() {
    this.resource("tests", function() {
        this.resource("test", { path: ":test_id" });
    });
});