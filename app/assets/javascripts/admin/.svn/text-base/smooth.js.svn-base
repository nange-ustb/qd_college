/* path to the stylesheets for the color picker */
var style_path = "/assets/colors";
var init_frm_height = 880, frm_height = 880;

function auto_height(mainheight){
    var left_height = $("#left").height();
    if(mainheight != undefined && mainheight > init_frm_height ){
        frm_height = mainheight;
    }
    var right_height = frm_height;
    var max_height = right_height;
    if(left_height < right_height){
        max_height = right_height;
    }else{
        max_height = left_height;
    }

    $("#contentfrm").css('height', max_height + 'px');
    $(".box").css('height', max_height + 'px');
    $("#right").css('height', max_height+ 10 + 'px');
    $("#content").css('height', max_height+ 'px');

//    $("#contentfrm").height(max_height);
//    $(".box").height(max_height);
//    $("#right").height(max_height+10);
//    $("#content").height(max_height);
}

$(document).ready(function () {
    /* messages fade away when dismiss is clicked */
    $(".message > .dismiss > a").live("click", function (event) {
        var value = $(this).attr("href");
        var id = value.substring(value.indexOf('#') + 1);

        $("#" + id).fadeOut('slow', function () { });

        return false;
    });

    /* color picker */
    $("#colors-switcher > a").click(function () {
        var style = $("#color");

        style.attr("href", "" + style_path + "/" + $(this).attr("title").toLowerCase() + ".css");

        return false;
    });

    $("#menu h6 a").click(function () {
        var link = $(this);
        var value = link.attr("href");
        var id = value.substring(value.indexOf('#') + 1);

        var heading = $("#h-menu-" + id);
        var list = $("#menu-" + id);

        if (list.attr("class") == "closed") {
            heading.attr("class", "selected");
            list.attr("class", "opened");
        } else {
            heading.attr("class", "");
            list.attr("class", "closed");
        }
        auto_height();
    });

    $("#menu li[class~=collapsible]").click(function (event) {
        var element = $(this);
        if($(event.target).parent().attr("class") != "collapsible"){
        }else{
            element.children("a:first-child").each(function () {
                var child = $(this);

                if (child.attr("class") == "plus") {
                    child.attr("class", "minus");
                } else {
                    child.attr("class", "plus");
                }
            });

            element.children("ul").each(function () {
                var child = $(this);

                if (child.attr("class") == "collapsed") {
                    child.attr("class", "expanded");
                } else {
                    child.attr("class", "collapsed");
                }
            });
            auto_height();
        }

    });

    /* left and quick menu */
    $(".opened > li > a").click(function(event){
        $("#right > div.box >div.title > h5").html($(this).html());
    });
    $("#quick ul > li > a, #quick li > a ").click(function(event){
        $("#right > div.box > div.title > h5").html($(this).html());
    });


});