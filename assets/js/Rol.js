class Rol {
    // Constructor
    constructor(id, nombre, descripcion, evento) {
        this.id = id || null;
        this.nombre = nombre || '';
        this.descripcion = descripcion || '';
        this.listaEvento = evento || null;
    }

    //Getter
    get Read() {
        NProgress.start();
        var miAccion = this.id == null ?  'ReadAll'  : 'Read';
        if(miAccion=='ReadAll' && $('#tRol tbody').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/Rol.php",
            data: {
                action: miAccion,
                id: this.id
            }
        })
            .done(function (e) {
                rol.Reload(e);
            })
            .fail(function (e) {
                rol.showError(e);
            })
            .always(NProgress.done());
    }

    get Save() {
        NProgress.start();
        $('#btnRol').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';
        this.nombre = $("#nombre").val();
        this.descripcion = $("#descripcion").val();
        // Lista de eventos seleccionados.
        this.listaEvento = $('#evento > option:selected').map(function () { return this.value; }).get();
        $.ajax({
            type: "POST",
            url: "class/Rol.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(rol.showInfo)
            .fail(function (e) {
                rol.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnRol").removeAttr("disabled")', 1000);
                rol = new Rol();
                rol.ClearCtls();
                rol.Read;
                $("#nombre").focus();
                NProgress.done();
            });
    }

    get Delete() {
        $.ajax({
            type: "POST",
            url: "class/Rol.php",
            data: {
                action: 'Delete',
                id: this.id
            }
        })
            .done(function (e) {
                var data = JSON.parse(e);
                if(data.status==0)
                    swal({
                        //
                        type: 'success',
                        title: 'Eliminado!',
                        showConfirmButton: false,
                        timer: 1000
                    });
                else if(data.status==1){
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
                rol.showError(e);
            })
            .always(function () {
                rol = new Rol();
                rol.Read;
            });
    }

    get List() {
        var miAccion= 'ReadAll';
        $.ajax({
            type: "POST",
            url: "class/Rol.php",
            data: { 
                action: miAccion
            }
        })
        .done(function( e ) {
            rol.ShowList(e);
        })    
        .fail(function (e) {
            rol.showError(e);
        })
        .always(function (e){
            $("#rol").selectpicker("refresh");
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
        $("#descripcion").val('');
        $('#evento option').prop("selected", false);
        $("#evento").selectpicker("refresh");
    };

    ShowAll(e) {
        var t= $('#tRol').DataTable();
        t.clear();
        t.rows.add(JSON.parse(e));
        t.draw();
        $( document ).on( 'click', '.delete', rol.DeleteEventHandler);
        $( document ).on( 'click', '#tRol tbody tr td:not(.buttons)', 
            rol.viewType==undefined || rol.viewType==rol.tUpdate ? rol.UpdateEventHandler : rol.SelectEventHandler
        );
    };

    UpdateEventHandler() {
        rol.id = $(this).parents("tr").find(".itemId").text() || $(this).find(".itemId").text();  //Class itemId = ID del objeto.
        rol.Read;
    };

    ShowItemData(e) {
        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e);
        rol = new Rol(data.id, data.nombre, data.descripcion, data.listaEvento);
        // Asigna objeto a controles
        $("#id").val(rol.id);
        $("#nombre").val(rol.nombre);
        $("#myModalLabel").html('<h1>' + rol.nombre + '<h1>' );
        $("#descripcion").val(rol.descripcion);
        // eventos.
        $.each(rol.listaEvento, function(i, item){
            $('#evento option[value=' + item.id + ']').prop("selected", true);
        });
        $("#evento").selectpicker("refresh");
        // modal
        $(".modal").modal('toggle');
    };

    ShowList(e) {
        // carga lista con datos.
        var data = JSON.parse(e);
        // Recorre arreglo.
        $.each(data, function (i, item) {
            $('#rol').append(`
                <option value=${item.id}>${item.nombre}</option>
            `);
        })
    };

    DeleteEventHandler() {
        rol.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
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
                rol.Delete;
            }
        })
    };


    setTable(buttons=true){
        $('#tRol').DataTable({
            responsive: true,
            info: false,
            "order": [[ 1, "asc" ]],
            "language": {
                "infoEmpty": "Sin Usuarios Registrados",
                "emptyTable": "Sin Usuarios Registrados",
                "search": "Buscar",
                "zeroRecords":    "No hay resultados",
                "lengthMenu":     "Mostar _MENU_ registros",
                "paginate": {
                    "first":      "Primera",
                    "last":       "Ultima",
                    "next":       "Siguiente",
                    "previous":   "Anterior"
                }
            },
            columns: [
                {
                    title: "id",
                    data: "id",
                    className: "itemId",                    
                    searchable: false
                },
                { title: "Nombre", data: "nombre" },
                { title: "Descripción", data: "descripcion" },
                {
                    title: "Accion",
                    orderable: false,
                    searchable:false,
                    visible: buttons,
                    className: "buttons",
                    width: '5%',
                    mRender: function () {
                        return '<a class="delete" style="cursor: pointer;"> <i class="glyphicon glyphicon-trash"> </i>  </a>'                            
                    }
                }
            ]
        });
    }

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms[0]);
        $('#frmRol').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                rol.Save;
            return false;
        });

        // on form "reset" event
        document.forms[0].onreset = function (e) {
            validator.reset();
        }
    };
}

//Class Instance
let rol = new Rol();