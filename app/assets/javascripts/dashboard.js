$(document).ready(function () {
    $(".dashboard a").mouseover(function () {
        $(".dashboard a img").css("display", "none"); // hide all product images
        $(this).find("img").css("display", "inline-block"); // show current hover image
    })
    $(".dashboard a").mouseout(function () {
        $(".dashboard a img").css("display", "none"); // hide all product images
    })
});
