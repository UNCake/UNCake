<%@ page import="uncake.GradesController" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="navbar"/>
    <title>Perfil</title>

    <script type="text/javascript" src="https://www.google.com/jsapi"></script>

    <asset:stylesheet src="schedule.css"/>
    <asset:stylesheet src="profile.css"/>

    <script>
        $(function () {

            var loadSchedule = function() {
                var url = "${createLink(controller:'Schedule', action:'showSchedule')}";
                $("#divImg").hide();
                var response = $.ajax({
                    url: url,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: {
                        friend: "${ftg.name}"
                    },
                    success: function (schedule) {
                        if (schedule != "") {
                            $("#divSch").html(schedule[0]);
                        } else {
                            $("#divImg").show();
                        }
                    },

                    error: function (request, status, error) {
                        alert(error)
                    }
                });
            };

            loadSchedule();

        });

    </script>
</head>

<body style=" background-color:rgba(0, 0, 0, 0.2); ">

<div class="container " >

    <br>
    <div class="row">
        <div class= "col-md-4 col-sm-4">
            <g:if test="${ftg.avatar == null}">
                <img src="${resource(dir: 'images', file: 'avatar.png')}" class="img-responsive">

            </g:if>
            <g:if test="${ftg.avatar != null}">
                <img class=" img-responsive  " style="text-align: center" src="${createLink(controller:'user', action:'avatar_image', id:ftg.ident())}" />
            </g:if>

        </div>
        <div class= " col-md-8 col-sm-8">
            <div class="row">
                <p class="row font-usuario " style="margin-right: 0px ; margin-left: 0px" >
                    <g:if test="${ftg != null}">
                        ${ftg.name}

                    </g:if>
                </p>
            </div>



        </div>
    </div>
    <br>
    <br>
    <div class="row">
        <div class="col-md-9 col-sm-9" id="divSch">
        </div>
        <div class="col-md-9 col-sm-9" id="divImg">
            <asset:image src="horario.PNG" class="img-responsive"/>
        </div>
        <div class="row">
            <a href="/profile" class=" btn btn-default btn-lg" style="margin-top: 10%">Volver</a>
        </div>
    </div>

    <!-- <a href="#" class="btn btn-primary btn-xs" >Agregar amigos</a>-->


</div>

</body>
</html>