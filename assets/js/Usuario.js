class Usuario {
    // Constructor
    constructor(id, nombre, username, password, email, activo, r, b) {
        this.id = id || null;
        this.nombre = nombre || '';
        this.username = username || '';
        this.password = password || '';
        this.email = email || '';
        this.activo = activo || 0; //1: activo; 0: inactivo.
        this.listarol = r || null;
        this.bodegas = b || null;
    }

    get tUpdate()  {
        return this.update ="update"; 
    }

    get tSelect()  {
        return this.select = "select";
    }

    set viewEventHandler(_t) {
        this.viewType = _t;        
    }
    //Getter
    get Read() {
        // NProgress.start();
        var miAccion = this.id == null ? 'ReadAll' : 'Read';
        if(miAccion=='ReadAll' && $('#tUsuario tbody').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/Usuario.php",
            data: {
                action: miAccion,
                id: this.id
            }
        })
            .done(function (e) {
                usuario.Reload(e);
            })
            .fail(function (e) {
                usuario.showError(e);
            })
            .always(/*NProgress.done()*/);
    }

    get Save() {
        NProgress.start();
        $('#btnUsuario').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';
        this.nombre = $("#nombre").val();
        this.username = $("#username").val();
        if(this.password==$("#password").val())
            this.password = 'NOCHANGED';
        else this.password = $("#password").val();
        this.email = $("#email").val();
        this.activo = $("#activo")[0].checked;
        this.listarol = $('#rol > option:selected').map(function () { return this.value; }).get();
        this.bodegas = $('#selbodega option:selected').map(function () { return this.value; }).get();
        $.ajax({
            type: "POST",
            url: "class/Usuario.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(usuario.showInfo)
            .fail(function (e) {
                usuario.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnUsuario").removeAttr("disabled")', 1000);
                usuario = new Usuario();
                usuario.ClearCtls();
                usuario.Read;
                $("#nombre").focus();
                NProgress.done();
            });
    }

    get Delete() {
        $.ajax({
            type: "POST",
            url: "class/Usuario.php",
            data: {
                action: 'Delete',
                id: this.id
            }
        })
            .done(function (e) {
                var data = JSON.parse(e);
                if (data.status == 0)
                    swal({
                        //
                        type: 'success',
                        title: 'Eliminado!',
                        showConfirmButton: false,
                        timer: 1000
                    });
                else if (data.status == 1) {
                    swal({
                        type: 'error',
                        title: 'No es posible eliminar...',
                        text: 'El registro que intenta eliminar tiene objetos relacionados'                        
                    });
                }
                else {
                    swal({
                        type: 'error',
                        title: 'Ha ocurrido un error...',
                        text: 'El registro no ha sido eliminado',
                        footer: '<a href>Contacte a Soporte Técnico</a>',
                    })
                }
            })
            .fail(function (e) {
                usuario.showError(e);
            })
            .always(function () {
                usuario = new Usuario();
                usuario.Read;
            });
    }

    // Methods
    Reload(e) {
        if (this.id == null)
            this.ShowAll(e);
        else this.ShowItemData(e);
    };

    // Muestra información en ventana
    showInfo() {
        //$(".modal").css({ display: "none" });   
        $(".close").click();
        swal({
            
            type: 'success',
            title: 'Good!',
            showConfirmButton: false,
            timer: 1000
        });
    };

    // Muestra errores en ventana
    showError(e) {
        //$(".modal").css({ display: "none" });  
        var data = JSON.parse(e.responseText);
        swal({
            type: 'error',
            title: 'Oops...',
            text: 'Algo no está bien (' + data.code + '): ' + data.msg,
            footer: '<a href>Contacte a Soporte Técnico</a>',
        })
    };

    ClearCtls() {
        $("#id").val('');
        $("#nombre").val('');
        $("#username").val('');
        $("#password").val('');
        $("#repetir").val('');
        $("#email").val('');
        if($("#activo").length>0)
            $("#activo")[0].checked=true;        
        $('#rol option').prop("selected", false);
        if($("#rol").length>0)
            $("#rol").selectpicker("refresh");
        $('#selbodega option').prop("selected", false);
        if($("#selbodega").length>0)
            $("#selbodega").selectpicker("refresh");
        //
        $('#checkusername').removeClass('fa-check-circle');
        $('#checkusername').removeClass('fa-times-circle');
        $('#checkusername').text('');
    };

    ShowAll(e) {
        var t= $('#tUsuario').DataTable();
        t.clear();
        t.rows.add(JSON.parse(e));
        t.draw();
        // eventos
        $( document ).on( 'click', '.delete', usuario.DeleteEventHandler);
        $( document ).on( 'click', '#tUsuario tbody tr td:not(.buttons)', 
            usuario.viewType==undefined || usuario.viewType==usuario.tUpdate ? usuario.UpdateEventHandler : usuario.SelectEventHandler
        );
    };

    UpdateEventHandler() {
        usuario.id = $(this).parents("tr").find(".itemId").text() || $(this).find(".itemId").text(); //Class itemId = ID del objeto.
        usuario.Read;
    };

    SelectEventHandler() {
        // Limpia el controles
        //bodega.ClearCtls();
        // carga objeto.
        usuario= new Usuario();
        usuario.id = $(this).parents("tr").find(".itemId").text() || $(this).find(".itemId").text();
        usuario.nombre = $(this).parents("tr").find("td:eq(1)").text() || $(this).find("td:eq(1)").text();
        usuario.username = $(this).parents("tr").find("td:eq(2)").text() || $(this).find("td:eq(2)").text();
        usuario.email = $(this).parents("tr").find("td:eq(3)").text() || $(this).find("td:eq(3)").text();
        // Asigna objeto a controles
        $("#nombre").val(usuario.nombre);
        $("#username").val(usuario.descripcion);
        $("#email").val(usuario.tipo);
        // oculta el modal   
        $('#modalUsuario').modal('toggle');
        // $("#usuarioRecibe").val($(this).parents("tr").find("td:eq(2)").html());
        // ordenSalida.idUsuarioRecibe = $(this).parents("tr").find("td:eq(1)").html();
        // $('#modal-usuarioRecibe').modal('toggle');
        // $("#estado").focus();
    };

    ShowItemData(e) {
        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e);
        usuario = new Usuario(data.id, data.nombre, data.username, data.password, data.email, data.activo, data.listarol, data.bodegas);
        // Asigna objeto a controles
        $("#id").val(usuario.id);
        $("#nombre").val(usuario.nombre);
        $("#username").val(usuario.username);
        $("#myModalLabel").html('<h1>' + usuario.username + '<h1>' );
        $("#password").val(usuario.password);
        $("#repetir").val(usuario.password);
        // checkbox
        if(usuario.activo==1){
            // $('#activo').prop('checked', true);
            $("#activo")[0].checked=true;
            // var elem = document.querySelector('#activo');
            // var init = Switchery(elem);
        }
        else {
            $("#activo")[0].checked=false;
            // $('#activo').prop('checked', false);
            // var elem = document.querySelector('#activo');
            // var init = Switchery(elem);
        }
        $("#email").val(usuario.email);
        //roles 
        $.each(usuario.listarol, function (i, item) {
            $('#rol option[value=' + item.id + ']').prop("selected", true);
        });
        $("#rol").selectpicker("refresh");
        //bodega
        $.each(usuario.bodegas, function (i, item) {
            $('#selbodega option[value=' + item.idBodega + ']').prop("selected", true);
        });
        $("#selbodega").selectpicker("refresh");
        // modal
        $(".modal").modal('toggle');
    };

    DeleteEventHandler() {
        usuario.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
        // Mensaje de borrado:
        swal({
            title: 'Eliminar?',
            text: "Esta acción es irreversible!",
            type: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, eliminar!',
            cancelButtonText: 'No, cancelar!',
            confirmButtonClass: 'btn btn-success',
            cancelButtonClass: 'btn btn-danger'
        }).then((result) => {
            if (result.value) {
                usuario.Delete;
            }
        })
    };

    CheckUsername() {
        if ($('#username').val() == "")
            return;
        $('#btnUsuario').attr("disabled", "disabled");
        var miAccion = 'CheckUsername';
        this.username = $("#username").val();
        $.ajax({
            type: "POST",
            url: "class/Usuario.php",
            data: {
                action: miAccion,
                username: this.username
            }
        })
            .done(function (e) {
                var data = JSON.parse(e);
                if (data.status == 0) {//0= unico; 1= usado.
                    $('#checkusername').removeClass('fa-times-circle');
                    $('#checkusername').addClass('fa-check-circle');
                    $("#btnUsuario").removeAttr("disabled");
                    $('#checkusername').text(' Nombre de usuario único.');
                }
                else {
                    $('#checkusername').removeClass('fa-check-circle');
                    $('#checkusername').addClass('fa-times-circle');
                    $('#checkusername').text(' Nombre de usuario repetido.');
                }

            })
            .fail(function (e) {
                usuario.showError(e);
            });
    }

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms[0]);
        $('#frmUsuario').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                usuario.Save;
            return false;
        });

        // on form "reset" event
        document.forms[0].onreset = function (e) {
            validator.reset();
        }

        // Check username
        $('#username').focusout(function () {
            usuario.CheckUsername();
        });        
    };


    setTable(buttons=true){
        $('#tUsuario').DataTable({
            responsive: true,
            info: false,
            destroy: true,
            columns: [
                {
                    title: "id",
                    data: "id",
                    className: "itemId",                    
                    searchable: false
                }, 
                { title: "Nombre", data: "nombre" },
                { title: "username", data: "username" },
                { title: "email", data: "email" },
                { title: "Activo", data: "activo" },
                {
                    title: "Action",
                    orderable: false,
                    searchable:false,
                    visible: buttons,
                    className: "buttons",
                    width:'5%',
                    mRender: function () {
                        return '<a class="delete" style="cursor: pointer;" > <i class="glyphicon glyphicon-trash"> </i> </a>'                            
                    }
                }
            ]
        });
    }
}

//Class Instance
let usuario = new Usuario();