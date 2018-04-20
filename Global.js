function toggle(div_id) {
    var el = document.getElementById(div_id);
    if (el.style.display == 'none') { el.style.display = 'block'; }
    else { el.style.display = 'none'; }
}

function blanket_size(popUpDivVar, blanketID) {
    if (typeof window.innerWidth != 'undefined') {
        viewportheight = window.innerHeight;
    } else {
        viewportheight = document.documentElement.clientHeight;
    }
    if ((viewportheight > document.body.parentNode.scrollHeight) && (viewportheight > document.body.parentNode.clientHeight)) {
        blanket_height = viewportheight;
    } else {
        if (document.body.parentNode.clientHeight > document.body.parentNode.scrollHeight) {
            blanket_height = document.body.parentNode.clientHeight;
        } else {
            blanket_height = document.body.parentNode.scrollHeight;
        }
    }
    var blanket = document.getElementById(blanketID);
    blanket.style.height = blanket_height + 'px';

    var popUpDiv = document.getElementById(popUpDivVar);
    popUpDiv_height = blanket_height / 2 - 150; //150 is half popup's height
    popUpDiv.style.top = popUpDiv_height + 'px';
}
function window_pos(popUpDivVar, intTop, intWidth) {
    if (typeof window.innerWidth != 'undefined') {
        viewportwidth = window.innerHeight;
    } else {
        viewportwidth = document.documentElement.clientHeight;
    }
    if ((viewportwidth > document.body.parentNode.scrollWidth) && (viewportwidth > document.body.parentNode.clientWidth)) {
        window_width = viewportwidth;
    } else {
        if (document.body.parentNode.clientWidth > document.body.parentNode.scrollWidth) {
            window_width = document.body.parentNode.clientWidth;
        } else {
            window_width = document.body.parentNode.scrollWidth;
        }
    }
    var popUpDiv = document.getElementById(popUpDivVar);
    var wLeft = (window_width) / 2 - (intWidth / 2); //150 is half popup's width
    popUpDiv.style.left = wLeft + 'px';
    popUpDiv.style.top = intTop + 'px';

}

function popup(windowname, strlocation, intTop, divBlanket, intWidth) {

    blanket_size(windowname, divBlanket);
    window_pos(windowname, intTop, intWidth);
    toggle(divBlanket);
    toggle(windowname);
    if (strlocation != '') { document.location = strlocation; }
}

/*Login*/
 function sucessLogin() {
            //$('#<%=NavigationDefaultMenu.ClientID%>').slideToggle("slow")
            //$('#DivDefault').slideDown("slow");
            $('#DivMainMenu').slideDown("slow");
            //$('#DivMainMenu').css('visibility', 'visible');
        }

