// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery/jquery.jstree
//= require jquery/jquery.hotkeys
//= require jquery/jquery.cookie
//= require jquery/jquery.alerts
//= require jquery/jquery_ujs
//= require jquery/jquery-ui-1.9.2.custom.min
//= require jquery/jquery-ui-timepicker-addon
//= require jquery/jquery.ui.datepicker-zh-CN
//= require jquery/jquery-ui-timepicker-zh-CN
//= require kindeditor


$.timepicker.setDefaults( {hourGrid: 4, minuteGrid: 10} )

//==begin sortable
var fixHelper = function(e, ui) {
    ui.children().each(function() {
        $(this).width($(this).width());
    });
    return ui;
};

$('table.sortable').ready(function(){
    var td_count = $(this).find('tbody tr:first-child td').length
    $('table.sortable tbody').sortable(
        {
            handle: '.handle',
            helper: fixHelper,
            placeholder: 'ui-sortable-placeholder',
            update: function(event, ui) {
                $("#progress").show();
                positions = {};
                $.each($('table.sortable tbody tr'), function(position, obj){
                    reg = /(\w+_?)+_(\d+)/;
                    parts = reg.exec($(obj).attr('id'));
                    if (parts) {
                        positions['positions['+parts[2]+']'] = position;
                    }
                });
                $.ajax({
                    type: 'POST',
                    dataType: 'script',
                    url: $(ui.item).closest("table.sortable").data("sortable-link"),
                    data: positions,
                    success: function(data){ $("#progress").hide(); }
                });
            },
            start: function (event, ui) {
                // Set correct height for placehoder (from dragged tr)
                ui.placeholder.height(ui.item.height())
                // Fix placeholder content to make it correct width
                ui.placeholder.html("<td colspan='"+(td_count-1)+"'></td><td class='actions'></td>")
            },
            stop: function (event, ui) {
                // Fix odd/even classes after reorder
                $("table.sortable tr:even").removeClass("odd even").addClass("even");
                $("table.sortable tr:odd").removeClass("odd even").addClass("odd");
            }

        });
});
//==end sortable

