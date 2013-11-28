$(document).ready(function () {
    var URL = '/api/v1/node/parents/';

    var _event = {
        keyInput: function () {
            console.log('hit');
            window.clearTimeout(this.timerAutoSave);
            this.timerAutoSave = window.setTimeout(_event.autoSave.bind(this), this.timerDelay);
        },

        autoSave: function () {
            var self = this;
            var data = this.$el.find('form').serialize();

            this.$el.find('.status').removeClass('error');
            this.$el.find('.status').addClass('loading');

            $.ajax({
                type: 'PUT',
                url: URL + this.id + '.json',
                data: data
            }).done(function (response) {
                self.$el.find('.sample').get(0).innerText = response.xml;
            }).error(function () {
                console.log('error');
                self.$el.find('.status').addClass('error');
            }).always(function () {
                self.$el.find('.status').removeClass('loading');
            });
        }
    };

    window.NodeParent = window.Class.extend({
        $el: null,
        id: null,
        timerAutoSave: null,
        timerDelay: 300,

        init: function ($el) {
            this.$el = $el;
            this.id = this.$el.attr('id');

            this.bind();
        },

        bind: function () {
            this.$el.find('input[type="text"]')
                .keydown(_event.keyInput.bind(this));
        }
    });
});