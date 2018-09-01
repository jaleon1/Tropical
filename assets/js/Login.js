var url;
var t= null;
var mouseX;
var mouseY;

$(document).ready(function () {
    //keyboard
    $(function () {
        "use strict";
    
        jqKeyboard.init();
    });
        
    //Validator.js
    var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms[0]);
    $('#frmLogin').submit(function(e){
        e.preventDefault();
        var validatorResult = validator.checkAll(this);
        if (validatorResult.valid)
            Login();    
        return false;
    });

    $(document).mousemove( function(e) {
        mouseX = e.pageX; 
        mouseY = e.pageY;
    }); 

    $('#btnKeyboar').click(function(){           
        $('#numPad').css({'top':mouseY,'left':mouseX+50}).fadeIn('slow');
        selector = $('#username');
    });

    // on form "reset" event
    document.forms[0].onreset = function (e) {
      validator.reset();
    }    
    //
    $('#dsItemsBodega tbody').on('click', 'tr', function () {
        var data = t.row(this).data();
        $.ajax({
            type: "POST",
            url: "class/Usuario.php",
            data: {
                action: 'setBodega',               
                idBodega: data.idBodega,
                nombre: data.nombre
            }        
        })
        .done(function( e ) {       
            if(url)  
                location.href= data.url || 'Dashboard.html';
        })
        .fail(function( e ) {
            showError(e);
        });
    });
   
});

function Login(){
    $.ajax({
        type: "POST",
        url: "class/Usuario.php",
        data: {
            action: 'Login',               
            username:  $("#username").val(),
            password: $("#password").val(),
            ip: localip,
            beforeSend: function(){
                 $("#error").fadeOut();
            } 
        }        
    })
    .done(function( e ) {
        var data= JSON.parse(e);
        if(data.status=='login'){
            // si el usuario está relacionado con mas de una bodega debe seleccionarla en modal
            if(data.bodegas.length>1){
                url= data.url;
                ShowAll(data);
                $("#modal-bodega").modal('toggle');                
            }
            else if(data.url)        
                location.href= data.url || 'Dashboard.html';
        }
        else if(data.status=='inactivo')
            $("#error").fadeIn(500, function(){
                $("#error").html(`                    
                    <div class="alert alert-danger alert-dismissible fade in" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
                        Usuario <strong>INACTIVO</strong>.
                    </div>
                `);
            });  
        else if(data.status=='noexiste')
            $("#error").fadeIn(500, function(){
                $("#error").html(`                    
                    <div class="alert alert-danger alert-dismissible fade in" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
                        Usuario <strong>NO EXISTE</strong>, favor registrarse.
                    </div>
                `);
            });  
        else if(data.status=='noip')
            swal({
                //
                type: 'error',
                title: 'Número de IP no autorizada',
                text: 'ip: ' + localip,
                showConfirmButton: false,
                timer: 3000
            });
        else
            $("#error").fadeIn(500, function(){      
                $("#error").html(`                    
                    <div class="alert alert-danger alert-dismissible fade in" role="alert">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
                        Usuario / Contraseña <strong>Inválidos</strong>.
                    </div>
                `);
            });        
    })    
    .fail(function( e ) {
        showError(e);
    });
};

function showError(e) {
    //$(".modal").css({ display: "none" });  
    var data = JSON.parse(e.responseText);
    swal({
        type: 'error',
        title: 'Oops...',
        text: 'Algo no está bien (' + data.code + '): ' + data.msg, 
        footer: '<a href>Contacte a Soporte Técnico</a>',
    })
};

function ShowAll(data) {
    // carga la tabla desde un array.
    t= $('#dsItemsBodega').DataTable ({
        responsive: true,      
        pagging: false,
        searching: false,
        bPaginate: false,
        bLengthChange: false,
        distroy: true,
        info:false,
        data : data.bodegas,              
        "language": {
            "infoEmpty": "Sin Productos Ingresados",
            "emptyTable": "Sin Productos Ingresados",
            "search": "Buscar",
            "zeroRecords":    "No hay resultados",
            "lengthMenu":     "Mostrar _MENU_ registros",
            "paginate": {
                "first":      "Primera",
                "last":       "Ultima",
                "next":       "Siguiente",
                "previous":   "Anterior"
            }
        },  
        columns : [
            { "data" : "idBodega" },
            { "data" : "nombre" }
        ],
        columnDefs: [
            {//id
            targets: 0,
            visible: false,
            searchable: false,
            className: "itemId"
            }
        ]
    });
};
