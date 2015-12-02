/**
 * Created by santiago on 11/8/15.
 */

function saveComment(link, courseCode, id, name) {
    var comm=document.getElementById('text').value;
    $.ajax({url: link,
    data: {
        comment: comm,
        code: courseCode,
        id: id,
    }
    });
    addComment(comm, name);
}

function addComment(comm, name) {
    var date = new Date();
    var day = date.getDate();
    var month = date.getMonth()+1;
    var year = date.getFullYear();
    var hour = date.getHours();
    var minutes = date.getMinutes();
    var seconds = date.getSeconds();
    var ampm = hour >= 12 ?  'PM' : 'AM';
    hour %= 12;
    var newItem = $("<li class='list-group-item col-md-8 well well-sm col-md-offset-2'><small>Fecha: "+month+"/"+day+"/"+year+" - "+hour+":"+minutes+":"+seconds+" "+ampm+"</small><h3>"+name+" escribio: <br></h3><p>"+comm+"<br></p></li>").hide();
    $("#commentList").append(newItem);
    newItem.fadeIn();
}


//$(document).ready(function(){

    /* The following code is executed once the DOM is loaded */

    /* This flag will prevent multiple comment submits: */
    //var working = false;
    //$("#submit").click(saveComment("/commentHandle/test"))
//});





