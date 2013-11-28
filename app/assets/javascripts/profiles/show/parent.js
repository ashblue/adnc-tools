$(document).ready(function () {
    // When the user stops typing auto submit
    // Serialize all form elements
    // Submit via puts to API
    // Activate status bar
    // On successful return query

    var _event = {
        keyInput: function () {

        },

        autosave: function () {

        }
    };

    window.ParentNode = Class.extend({
        $el: null,
        id: null,
        timerAutoSave: null,
        timerDelay: 5000,

        init: function ($el) {
            this.$el = $el;
            this.id = this.$el.data('id');
        },

        bind: function () {
            this.$el.find('input[type="test"]')
                .keydown(_event.keyInput);
        }
    });
});