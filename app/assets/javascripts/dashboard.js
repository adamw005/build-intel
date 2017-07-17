# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function () {
    $(".dashboard a").mouseover(function () {
        $(".dashboard a img").css("display", "none"); // hide all product images
        $(this).find("img").css("display", "inline-block"); // show current hover image
    })
    $(".dashboard a").mouseout(function () {
        $(".dashboard a img").css("display", "none"); // hide all product images
    })
});
