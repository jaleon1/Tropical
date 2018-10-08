class Bodega {
    // Constructor
    constructor(id, nombre, descripcion, ubicacion, contacto, telefono, tipo) {
        this.id = id || null;
        this.nombre = nombre || '';
        this.descripcion = descripcion || '';
        this.ubicacion = ubicacion || '';
        this.contacto = contacto || '';
        this.telefono = telefono || '';
        this.tipo = tipo || null;
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
        NProgress.start();
        var miAccion = this.id == null ?  'ReadAll'  : 'Read';
        if(miAccion=='ReadAll' && $('#tBodega tbody').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/Bodega.php",
            data: {
                action: miAccion,
                id: this.id
            }
        })
            .done(function (e) {
                bodega.Reload(e);
            })
            .fail(function (e) {
                bodega.showError(e);
            })
            .always(NProgress.done());
    }

    get Save() {
        NProgress.start();
        $('#btnBodega').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';
        this.nombre = $("#nombre").val();
        this.descripcion = $("#descripcion").val();
        this.ubicacion = $("#ubicacion").val();
        this.contacto = $("#contacto").val();        
        this.telefono = $("#telefono").val();
        this.tipo = $('#tipo option:selected').val();
        $.ajax({
            type: "POST",
            url: "class/Bodega.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(bodega.showInfo)
            .fail(function (e) {
                bodega.showError(e);
            })
            .always(function () {
                $("#btnBodega").removeAttr("disabled");
                bodega = new Bodega();
                bodega.ClearCtls();
                bodega.Read;
                $("#nombre").focus();
                NProgress.done();
            });
    }

    get Delete() {
        $.ajax({
            type: "POST",
            url: "class/Bodega.php",
            data: {
                action: 'Delete',
                id: this.id
            }
        })
            .done(function () {
                swal({
                    //
                    type: 'success',
                    title: 'Eliminado!',
                    showConfirmButton: false,
                    timer: 1000
                });
            })
            .fail(function (e) {
                bodega.showError(e);
            })
            .always(function () {
                bodega = new Bodega();
                bodega.Read;
            });
    }

    get ListTipos() {
        var miAccion= 'ListTipos';
        $.ajax({
            type: "POST",
            url: "class/Bodega.php",
            data: { 
                action: miAccion
            }
        })
        .done(function( e ) {
            bodega.ShowListTipo(e);
        })    
        .fail(function (e) {
            bodega.showError(e);
        })
        .always(function (e){
            $("#tipo").selectpicker("refresh");
        });
    }

    get List() {
        var miAccion= 'List';
        $.ajax({
            type: "POST",
            url: "class/Bodega.php",
            data: { 
                action: miAccion
            }
        })
        .done(function( e ) {
            bodega.ShowList(e);
        })    
        .fail(function (e) {
            bodega.showError(e);
        })
        .always(function (e){
            $("#selbodega").selectpicker("refresh");
        });
    }

    get readByUser() {
        var miAccion = "readByUser";
        $.ajax({
            type: "POST",
            url: "class/Bodega.php",
            data: {
                action: miAccion
            }
        })
            .done(function (e) {
                bodega.ShowAllD(e);
            })
            .fail(function (e) {
                bodega.showError(e);
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
            title: 'Listo!',
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
        $("#ubicacion").val('');
        $("#contacto").val('');
        $("#telefono").val('');
        $('#tipo option').prop("selected", false);
    };

    ShowAll(e) {
        // revisa si el dt ya está cargado.
        var t= $('#tBodega').DataTable();
         if(t.rows().count()==0){
            t.clear();
            t.rows.add(JSON.parse(e));
            t.draw();
            $( document ).on( 'click', '#tBodega tbody tr td:not(.buttons)', bodega.viewType==undefined || bodega.viewType==bodega.tUpdate ? bodega.UpdateEventHandler : bodega.SelectEventHandler);
            $( document ).on( 'click', '.delete', bodega.DeleteEventHandler);
            $( document ).on( 'click', '.openView', bodega.OpenEventHandler);
         }else{
            t.clear();
            t.rows.add(JSON.parse(e));
            t.draw();
         }
    };

    ShowAllD(e) {
        b.clear();
        b.rows.add(JSON.parse(e));
        b.draw();
    };

    AddBodegaEventHandler(){
        bodega.id=$(this).find('td:eq(1)').html();
        bodega.nombre=$(this).find('td:eq(2)').html();
        bodega.descripcion= $(this).find('td:eq(3)').html();
        bodega.tipo= $(this).find('td:eq(4)').html();
        //
        $('#nombre').val(bodega.nombre);
        $('#descripcion').val(bodega.descripcion);
        $('#tipo').val(bodega.tipo);
        $(".close").click();
    };

    OpenEventHandler() {
        // limpia dt
        var t= $('#tInsumo').DataTable();
        t.clear();
        t.draw();
        //
        insumobodega.idBodega = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
        insumobodega.ReadByBodega;
        $(".bs-insumo-modal-lg").modal('toggle');
        $("#nombrebodega").text($(this).parents("tr").find("td:eq(1)").text());        
    };

    UpdateEventHandler() {
        bodega.id = $(this).parents("tr").find(".itemId").text() || $(this).find(".itemId").text();
        bodega.Read;
    };

    ShowItemData(e) {
        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e)[0];
        bodega = new Bodega(data.id, data.nombre, data.descripcion, data.ubicacion, data.contacto, data.telefono, data.tipo);
        // Asigna objeto a controles
        $("#id").val(bodega.id);
        $("#nombre").val(bodega.nombre);
        $("#myModalLabel").html('<h1>' + bodega.nombre + '<h1>' );
        $("#descripcion").val(bodega.descripcion);
        $("#ubicacion").val(bodega.ubicacion);
        $("#contacto").val(bodega.contacto);
        $("#telefono").val(bodega.telefono);
        //fk 
        $('#tipo option[value=' + bodega.tipo + ']').prop("selected", true);    
        $("#tipo").selectpicker("refresh");
        $(".bs-bodega-modal-lg").modal('toggle');
    };

    SelectEventHandler() {
        // Limpia el controles
        bodega.ClearCtls();
        // carga objeto.
        bodega= new Bodega();
        bodega.id = $(this).parents("tr").find(".itemId").text() || $(this).find(".itemId").text();
        bodega.nombre = $(this).parents("tr").find("td:eq(1)").text() || $(this).find("td:eq(1)").text();
        bodega.descripcion = $(this).parents("tr").find("td:eq(2)").text() || $(this).find("td:eq(2)").text();
        bodega.tipo = $(this).parents("tr").find("td:eq(3)").text() || $(this).find("td:eq(3)").text();
        // Asigna objeto a controles
        $("#nombre").val(bodega.nombre);
        $("#descripcion").val(bodega.descripcion);
        $("#tipo").val(bodega.tipo);
        // oculta el modal   
        $(".bs-bodega-modal-lg").modal('toggle');
        if(bodega.tipo=='Interna')
            $("#frmTotales").hide();
        else
            $("#frmTotales").show(); 
    };

    ShowListTipo(e) {
        // carga lista con datos.
        var data = JSON.parse(e);
        // Recorre arreglo.
        $.each(data, function (i, item) {
            $('#tipo').append(`
                <option value=${item.id}>${item.nombre}</option>
            `);
        })
    };

    ShowList(e) {
        // carga lista con datos.
        var data = JSON.parse(e);
        // Recorre arreglo.
        $.each(data, function (i, item) {
                $('#selbodega').append(`
                    <option value=${item.id}>${item.nombre}</option>
                `);
        })
    };

    DeleteEventHandler() {
        bodega.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
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
                bodega.Delete;
            }
        })
    };

    setTable(buttons=true){
        $('#tBodega').DataTable({
            responsive: true,
            info: false,
            pageLength: 10,
            "order": [[ 1, "asc" ]],
            "language": {
                "infoEmpty": "Sin Usuarios Registrados",
                "emptyTable": "Sin Usuarios Registrados",
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
            columns: [
                {
                    title: "ID",
                    data: "id",
                    className: "itemId",                    
                    searchable: false
                },
                { title: "NOBRE", data: "nombre" },
                { title: "DESCRIPCION", data: "descripcion" },
                { title: "TIPO", data: "tipo" },
                {
                    title: "ACCION",
                    orderable: false,
                    searchable:false,
                    visible: buttons,
                    className: "buttons",
                    width: '5%',
                    mRender: function () {
                        return '<a class="delete" style="cursor: pointer;"> <i class="glyphicon glyphicon-trash"> </i> </a> | <a class="openView" style="cursor: pointer;"> <i class="glyphicon glyphicon-eye-open"> </i>  </a>' 
                    }
                }
            ]
        });
    }

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms["frmBodega"]);
        $('#frmBodega').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                bodega.Save;
            return false;
        });

        // on form "reset" event
        document.forms["frmBodega"].onreset = function (e) {
            validator.reset();
        }

    };
}

//Class Instance
let bodega = new Bodega();