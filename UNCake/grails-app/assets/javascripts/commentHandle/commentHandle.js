/**
 * Created by santiago on 11/8/15.
 */

function saveComment(link, courseCode, userId, name) {
    var comm=document.getElementById('text').value;
    $.ajax({url: link,
    data: {
        comment: comm,
        code: courseCode,
        id: userId
    }
    });
    addComment(comm, name);
}

function addComment(comm, name) {
    var newItem = $("<li class='list-group-item col-md-8 well well-sm'><h3>"+name+" escribio: <br></h3><p>"+comm+"<br></p></li>").hide();
    $("#commentList").append(newItem);
    newItem.fadeIn();
}


//$(document).ready(function(){

    /* The following code is executed once the DOM is loaded */

    /* This flag will prevent multiple comment submits: */
    //var working = false;
    //$("#submit").click(saveComment("/commentHandle/test"))
//});





