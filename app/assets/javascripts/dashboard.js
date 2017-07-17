$(document).ready(function () {
    $(".dashboard a").mouseover(function () {
        $(".dashboard a .popup_chart").css("display", "none"); // hide all product images
        $(this).find(".popup_chart").css("display", "inline-block"); // show current hover image
    })
    $(".dashboard a").mouseout(function () {
        $(".dashboard a .popup_chart").css("display", "none").css("transition-duration", "2s"); // hide all product images
    })
});
