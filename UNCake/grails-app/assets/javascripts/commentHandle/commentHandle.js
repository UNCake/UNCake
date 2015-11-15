/**
 * Created by santiago on 11/8/15.
 */

function ajaxTest(link) {
    $.ajax({url: link,
    data: {
        comment: document.getElementById('text').value
    }
    });
}


//$(document).ready(function(){

    /* The following code is executed once the DOM is loaded */

    /* This flag will prevent multiple comment submits: */
    //var working = false;
    //$("#submit").click(ajaxTest("/commentHandle/test"))
//});





