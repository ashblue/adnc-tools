/*
 *= require ./parent
 */
$(document).ready(function () {
    var show = {
        init: function () {
            $('[data-node="parent"').each(function () {
                new window.NodeParent($(this));
            });

        }
    };

    show.init();
});