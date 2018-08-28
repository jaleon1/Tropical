class InsumoBodega {
    // Constructor
    constructor(id, idBodega, codigo, nombre, descripcion, saldoCantidad, saldoCosto, costoPromedio) {
        this.id = id || null;
        this.idBodega = idBodega || null;
        this.codigo = codigo || '';
        this.nombre = nombre || '';
        this.descripcion = descripcion || '';
        this.saldoCantidad = saldoCantidad || 0;
        this.saldoCosto = saldoCosto || 0;
        this.costoPromedio = costoPromedio || 0;
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

    get Read() {
        var miAccion = this.id == null ?  'ReadAll'  : 'Read';
        if(miAccion=='ReadAll' && $('#tInsumo tbody').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/InsumosXBodega.php",
            data: {
                action: miAccion,
                id: this.id,
                // idBodega: this.idBodega no envpia el idBodega, toma el de la sesion.
            }
        })
            .done(function (e) {
                insumobodega.Reload(e);
            })
            .fail(function (e) {
                insumobodega.showError(e);
            });
    }

    get ReadByBodega() {
        var miAccion = this.id == null ?  'ReadAll'  : 'Read';
        if(miAccion=='ReadAll' && $('#tInsumo tbody').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/InsumosXBodega.php",
            data: {
                action: miAccion,                
                idBodega: this.idBodega
            }
        })
            .done(function (e) {
                insumobodega.Reload(e);
            })
            .fail(function (e) {
                insumobodega.showError(e);
            });
    }

    get Save() {
        $('#btnSubmit').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';        
        this.saldoCantidad = $("#saldoCantidad").val();
        this.saldoCosto = $("#saldoCosto").val();
        this.costoPromedio = $("#costoPromedio").val();
        $.ajax({
            type: "POST",
            url: "class/InsumosXBodega.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(insumobodega.showInfo)
            .fail(function (e) {
                insumobodega.showError(e);
            })
            .always(function () {
                $("#btnSubmit").removeAttr("disabled");
                insumobodega = new InsumoBodega();
                insumobodega.ClearCtls();
                insumobodega.Read;
            });
    }

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
        $("#producto").val('');
        $("#cantidad").val('');
        $("#costo").val('');
    };

    ShowAll(e) {
        var t= $('#tInsumo').DataTable();
        t.clear();
        var data = JSON.parse(e);
        $.each(data, function (i, item) {
            item.saldoCosto = "¢"+(parseFloat(item.saldoCosto).toFixed(2)).toString();
            item.costoPromedio = "¢"+(parseFloat(item.costoPromedio).toFixed(2)).toString();
        });
        t.rows.add(data);   
        t.draw();
    };

    UpdateEventHandler() {
        insumobodega.id = $(this).parents("tr").find(".itemId").text() || $(this).find(".itemId").text();           
        // abre modal para editar la cantidad.
        insumobodega.Read;
    };

    ShowItemData(e) {
        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e)[0];
        insumobodega = new InsumoBodega(data.id, data.idBodega, data.codigo, data.nombre, data.descripcion, data.saldoCantidad, data.saldoCosto, data.costoPromedio);
        $("#codigo").val(insumobodega.codigo);
        $("#nombre").val(insumobodega.nombre);
        $("#descripcion").val(insumobodega.descripcion);
        $("#saldoCantidad").val(insumobodega.saldoCantidad);
        $("#saldoCosto").val(insumobodega.saldoCosto);
        $("#costoPromedio").val(insumobodega.costoPromedio);
        //
        $("#myModalLabel").html('<h1>' + insumobodega.nombre + '<h1>' );
    };

    DeleteEventHandler() {
        insumobodega.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
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
                insumobodega.Delete;
            }
        })
    };

    setTable(buttons=true){
        $('#tInsumo').DataTable({
            responsive: true,
            info: false,
            "order": [[ 1, "asc" ]],
            "language": {
                "infoEmpty": "Sin insumos Registrados",
                "emptyTable": "Sin Insumos Registrados",
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
            columnDefs: [{className: "text-right", "targets": [4,5,6]}],
            columns: [
                {
                    title: "id",
                    data: "id",
                    className: "itemId",                    
                    searchable: false
                },
                { 
                    title: "Código", 
                    data: "codigo"       
                },
                { 
                    title: "Nombre", 
                    data: "nombre"       
                },
                { 
                    title: "Descripción", 
                    data: "descripcion"       
                },
                { 
                    title: "Cantidad", 
                    data: "saldoCantidad"       
                },
                { 
                    title: "Costo", 
                    data: "saldoCosto",
                    visible: false       
                },
                { 
                    title: "Costo Promedio", 
                    data: "costoPromedio",
                    visible: false       
                },
                {
                    title: "Action",
                    orderable: false,
                    searchable:false,
                    visible: buttons,
                    className: "buttons",
                    width: '5%',
                    mRender: function () {
                        return '<a class="delete"> <i class="glyphicon glyphicon-trash"> </i>  </a>'                            
                    }
                }
            ]
        });
    };

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms["frmInsumo"]);
        $('#frmInsumo').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                insumobodega.Save;
            return false;
        });

        // on form "reset" event
        if($('#frmInsumo').length > 0 )
            document.forms["frmInsumo"].onreset = function (e) {
                validator.reset();
            }
    };
}

//Class Instance
let insumobodega = new InsumoBodega();