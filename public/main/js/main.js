// ============ Left sidebar js ============

$(document).on('click', '#sidebar li', function() {
    $(this).addClass('active').siblings().removeClass('active');
});

// =============================
// Sidebar Toggle
// =============================

$(document).ready(function() {
    $("#toggleSidebar").click(function() {
        $(".left-menu").toggleClass("hide");
        $(".content-wrapper").toggleClass("hide");
    });
});