/*
 * jQuery Pimg (Preview image) 
 * Written by Dave Earley ( http://dave-earley.com )
 */

function pimg()
{
    this.xOffset = 5;
    this.yOffset = 50;
    $("img.pimg").hover(function (e)
    {
        this.img_title = this.title;
        this.title = "";
        var img_src = $(this).attr('img_src');
        var desc = (this.img_title != "") ? "<h3>" + this.img_title + "</h3>" : "";
        var image = (img_src) ? img_src : this.src;
        $("body").append("<div id='pimg'><img src='" + image + "' alt='Image preview' />" + desc + "</div>");
        $("#pimg").css("top", (e.pageY - xOffset) + "px").css("left", (e.pageX + yOffset) + "px");
        $("#pimg").fadeIn(700);
    }, function ()
    {
        this.title = this.img_title;
        $("#pimg").remove();

    });
    $("img.pimg").mousemove(function (e)
    {
        $("#pimg").css("top", (e.pageY - xOffset) + "px").css("left", (e.pageX + yOffset) + "px");
    });
};
