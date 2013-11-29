/*
 *= require ./parent
 *= require ./child
 */
$(document).ready(function () {
    var show = {
        init: function () {
            $('[data-node="parent"]').each(function () {
                new window.NodeParent($(this));
            });

            $('[data-node="child"]').each(function () {
                new window.NodeChild($(this));
            });
        }
    };

    show.init();
});