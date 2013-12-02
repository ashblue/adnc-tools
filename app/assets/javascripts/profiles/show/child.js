$(document).ready(function () {
    var _event = {
        changeHelper: function (e) {
            var $el = $(e.target);

            if ($el.val() === 'connectors') {
                this.$el.find('.attr').hide();
            } else {
                this.$el.find('.attr').show();
            }
        }
    };

    window.NodeChild = window.NodeParent.extend({
        url: '/api/v1/node/children/',

        bind: function () {
            this._super();

            this.$el.find('[name="node_child[helper]"]')
                .change(_event.changeHelper.bind(this));
        }
    });
});