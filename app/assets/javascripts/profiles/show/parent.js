$(document).ready(function () {
    var _event = {
        keyInput: function () {
            window.clearTimeout(this.timerAutoSave);
            this.timerAutoSave = window.setTimeout(_event.autoSave.bind(this), this.timerDelay);
        },

        autoSave: function () {
            var self = this;
            var data = this.$el.find('form').serialize();

            this.$el.find('.status').removeClass('error');
            this.$el.find('.status').addClass('loading');

            $.ajax(
                {
                    type: 'PUT',
                    url: this.url + this.id + '.json',
                    data: data
                }
            ).done(this.saveSuccess.bind(this))
            .error(this.saveError.bind(this))
            .always(this.saveAlways.bind(this));
        }
    };

    window.NodeParent = window.Class.extend({
        $el: null,
        id: null,
        timerAutoSave: null,
        timerDelay: 1000,
        url: '/api/v1/node/parents/',

        init: function ($el) {
            this.$el = $el;
            this.id = this.$el.attr('id');

            this.bind();
        },

        bind: function () {
            this.$el.find('input')
                .keydown(_event.keyInput.bind(this))

            this.$el.find('select')
                .change(_event.keyInput.bind(this));
        },

        saveSuccess: function (response) {
            this.$el.find('.sample').get(0).innerText = response.xml;
        },

        saveError: function () {
            this.$el.find('.status').addClass('error');
        },

        saveAlways: function () {
            this.$el.find('.status').removeClass('loading');
        }
    });
});