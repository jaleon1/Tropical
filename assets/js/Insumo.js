class Insumo {
    // Constructor
    constructor(id, codigo,nombre, descripcion, saldoCantidad, saldoCosto, costoPromedio) {
        this.id = id || null;
        this.codigo = codigo || '';
        this.nombre = nombre || '';
        this.descripcion = descripcion || '';
        this.saldoCantidad = saldoCantidad || 0;
        this.saldoCosto = saldoCosto || 0;
        this.costoPromedio = costoPromedio || 0;
    }

    //Getter
    get Read() {
        var miAccion = this.id == null ? 'ReadAll' : 'Read';
        if(miAccion=='ReadAll' && $('#tableBody-Insumo').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/Insumo.php",
            data: {
                action: miAccion,
                id: this.id
            }
        })
            .done(function (e) {
                insumo.Reload(e);
            })
            .fail(function (e) {
                insumo.showError(e);
            });
    }

    get Save() {
        $('#btnInsumo').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';
        this.codigo = $("#codigo").val();
        this.nombre = $("#nombre").val();
        this.descripcion = $("#descripcion").val();
        this.saldoCantidad = $("#saldoCantidad").val();
        this.saldoCosto = $("#saldoCosto").val();
        this.costoPromedio = $("#costoPromedio").val();
        $.ajax({
            type: "POST",
            url: "class/Insumo.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(insumo.showInfo)
            .fail(function (e) {
                insumo.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnInsumo").removeAttr("disabled")', 1000);
                insumo = new Insumo();
                insumo.ClearCtls();
                insumo.Read;
                $("#nombre").focus();
            });
    }

    get Delete() {
        $.ajax({
            type: "POST",
            url: "class/Insumo.php",
            data: {
                action: 'Delete',
                id: this.id
            }
        })
            .done(function (e) {
                var data = JSON.parse(e);
                if (data == 0)
                    swal({
                        type: 'success',
                        title: 'Eliminado!',
                        showConfirmButton: false,
                        timer: 1000
                    });
                else if (data.status == 1) {
                    swal({
                        type: 'error',
                        title: 'No es posible eliminar...',
                        text: 'El registro que intenta eliminar ya se ecnuentra liquidado'                        
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
                insumo.showError(e);
            })
            .always(function () {
                insumo = new Insumo();
                insumo.Read;
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
            position: 'top-end',
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
        $("#codigo").val('');
        $("#nombre").val('');
        $("#descripcion").val('');
        $("#saldoCantidad").val('');
        $("#saldoCosto").val('');
        $("#costoPromedio").val('');
    };

    ShowAll(e) {
        var url;
        url = window.location.href;
        // Limpia el div que contiene la tabla.
        $('#tableBody-Insumo').html("");
        // // Carga lista
        var data = JSON.parse(e);
        //style="display: none"
        $.each(data, function (i, item) {
            $('#tableBody-Insumo').append(`
                <tr> 
                    <td class="a-center ">
                        <input id="chk-addinsumo${item.id}" type="checkbox" class="flat" name="table_records">
                    </td>
                    <td class="itemId">${item.id}</td>
                    <td>${item.codigo}</td>
                    <td>${item.nombre}</td>
                    <td>${item.descripcion}</td>
                    <td>${item.saldoCantidad}</td>
                    <td>${parseFloat(item.saldoCosto).toFixed(2)}</td>
                    <td>${parseFloat(item.costoPromedio).toFixed(2)}</td>
                    <td class=" last">
                        <a  id="update" class="update" data-toggle="modal" data-target=".bs-example-modal-lg" > <i class="glyphicon glyphicon-edit" > </i> Editar </a> | 
                        <a  id="delete" class="delete"> <i class="glyphicon glyphicon-trash"> </i> Eliminar </a>
                    </td>
                </tr>
            `);
            // event Handler
            $(".update").click(insumo.UpdateEventHandler);
            $(".delete").click(insumo.DeleteEventHandler);
            if (url.indexOf("OrdenSalida.html")!=-1) {
                $('#chk-addinsumo'+item.id).change(ordenSalida.AddInsumoEventHandler);
            }
        })        
        //datatable         
        if ( $.fn.dataTable.isDataTable( '#dsInsumo' ) ) {
            var table = $('#dsInsumo').DataTable();
            //table.destroy();
        }
        else 
            $('#dsInsumo').DataTable( {          
                paging: true,
                search: true
            });
    };

    UpdateEventHandler() {
        insumo.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
        insumo.Read;
    };

    ShowItemData(e) {
        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e)[0];
        insumo = new Insumo(data.id, data.codigo, data.nombre, data.descripcion,
            data.saldoCantidad, data.saldoCosto, data.costoPromedio);
        // Asigna objeto a controles
        $("#id").val(insumo.id);
        $("#codigo").val(insumo.codigo);
        $("#nombre").val(insumo.nombre);
        $("#descripcion").val(insumo.descripcion);
        $("#saldoCantidad").val(insumo.saldoCantidad);
        $("#saldoCosto").val(parseFloat(insumo.saldoCosto).toFixed(2));
        $("#costoPromedio").val(parseFloat(insumo.costoPromedio).toFixed(2));
    };

    DeleteEventHandler() {
        insumo.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
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
                insumo.Delete;
            }
        })
    };

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms[0]);
        $('#frmInsumo').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                insumo.Save;
            return false;
        });

        // on form "reset" event
        document.forms[0].onreset = function (e) {
            validator.reset();
        }
        
        // datepicker.js
        // $('#dpfechaExpiracion').datetimepicker({
        //     format: 'DD/MM/YYYY'
        // });
    };
}

//Class Instance
let insumo = new Insumo();