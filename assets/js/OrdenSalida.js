class OrdenSalida {
    // Constructor
constructor(id, fecha, numeroorden, usuarioentrega, usuariorecibe, fechaliquida, estado, i) {
        this.id = id || null;
        this.fecha = fecha || '';
        this.usuarioentrega = usuarioentrega || '';
        this.usuariorecibe = usuariorecibe || '';
        this.fechaliquida = fechaliquida || '';
        this.estado = estado || 0;
        this.listainsumo = i || [];
    }

    //Getter
    get Read() {
        var miAccion = this.id == null ? 'ReadAll' : 'Read';
        if(miAccion=='ReadAll' && $('#tableBody-OrdenSalida').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/OrdenSalida.php",
            data: {
                action: miAccion,
                id: this.id
            }
        })
            .done(function (e) {
                ordensalida.Reload(e);
            })
            .fail(function (e) {
                ordensalida.showError(e);
            });
    }

    get Save() {
        if ($('#tableBody-OrdenSalida tr').length == 0){
            swal({
                type: 'info',
                title: 'Debe agregar los Insumos de la Orden de Salida...'                    
            });
            return;
        }
        $('#btnOrdenSalida').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';
        this.fecha = $("#dt_fecha").val();
        this.fechaliquida = $("#dt_fechaliquida").val();
        this.usuariorecibe = ordensalida.usuariorecibe;
        this.estado = 0;
        // lista de insumos
        ordensalida.listainsumo = [];
        $('#tableBody-OrdenSalida tr').each(function() {
            var objInsumo = new Object();
            objInsumo.id= $(this).find('td:eq(0)').html();
            objInsumo.cantidad= $(this).find('td:eq(7) input').val();
            objInsumo.costopromedio= $(this).find('td:eq(6)').html();
            ordensalida.listainsumo.push(objInsumo);
        });
        $.ajax({
            type: "POST",
            url: "class/OrdenSalida.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(ordensalida.showInfo)
            .fail(function (e) {
                ordensalida.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnOrdenSalida").removeAttr("disabled")', 1000);
                ordensalida = new OrdenSalida();
                ordensalida.ClearCtls();
                ordensalida.Read;
            });
    }

    get Delete() {
        $.ajax({
            type: "POST",
            url: "class/OrdenSalida.php",
            data: {
                action: 'Delete',
                id: this.id
            }
        })
            .done(function () {
                var data = JSON.parse(e);
                if (data.status == 0)
                    swal({
                        //position: 'top-end',
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
                ordensalida.showError(e);
            })
            .always(function () {
                ordensalida = new OrdenSalida();
                ordensalida.Read;
            });
    }

    // Methods
    UpdateCantidadProducto(){
        productobodega.idproducto = $(this).parents("tr").find("td:eq(1)").html();
        productobodega.cantidad = $(this).parents("tr").find("td:eq(5)").html();
        productobodega.idbodega = '22a80c9e-5639-11e8-8242-54ee75873a00';
        var idordensalida = $(this).parents("tr").find("td:eq(0)").html();
        productobodega.SaveCantidad(idordensalida);        
    };

    Reload(e) {
        if (this.id == null)
            this.ShowAll(e);
        else this.ShowItemData(e);
    };

    // Muestra información en ventana
    showInfo() {
        $(".close").click();
        swal({
            position: 'top-end',
            type: 'success',
            title: 'Good!',
            showConfirmButton: false,
            timer: 10000
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
        $("#usuariorecibe").val('');
        $("#dt_fechaliquida").val('');
        $('#tableBody-dsOrdenSalida').html("");
    };

    ShowAll(e) {
        // Limpia el div que contiene la tabla.
        $('#tableBody-OrdenSalida').html("");
        // // Carga lista
        var data = JSON.parse(e);
        //style="display: none"
        var estado="EN PROCESO";
        $.each(data, function (i, item) {
            if (item.estado=="0") 
                estado="EN PROCESO";
            else
                estado="TERMINADO";
            $('#tableBody-OrdenSalida').append(`
                <tr> 
                    <td class="itemId">${item.id}</td>
                    <td class="oculto">${item.idproducto}</td>
                    <td class="oculto">${item.idusuario}</td>
                    <td class="oculto">${item.usuariorecibe}</td>
                    <td>${item.producto}</td>
                    <td>${item.usuario}</td>
                    <td>${item.usuariorecibe}</td>
                    <td>${item.cantidad}</td>
                    <td>${estado}</td>
                    <td class=" last">
                        <a id="update${item.id}" class="update" data-toggle="modal" data-target=".bs-example-modal-lg" > <i class="glyphicon glyphicon-edit" > </i> Editar </a> | 
                        <a id="delete${item.id}" class="delete"> <i class="glyphicon glyphicon-trash"> </i> Eliminar </a>
                    </td>
                    <td class="a-center ">
                    <input id="chkterminado${item.id}" type="checkbox" class="flat" name="table_records">
                </td>
                </tr>
            `);
            $('#update'+item.id).click(ordensalida.UpdateEventHandler);
            $('#delete'+item.id).click(ordensalida.DeleteEventHandler);
            $('#chkterminado'+item.id).click(ordensalida.UpdateCantidadProducto);
            
        })        
        //datatable         
        if ( $.fn.dataTable.isDataTable( '#dsOrdenSalida' ) ) {
            var table = $('#dsOrdenSalida').DataTable();

        }
        else 
            $('#dsOrdenSalida').DataTable();
    };

    AddTableInsumo(id,codigo,nombre,descripcion,saldocantidad,saldocosto,costopromedio) {
        $('#tableBody-OrdenSalida').append(`
            <tr id="row"${id}> 
                <td class="itemId" >${id}</td>
                <td class=oculto>${codigo}</td>
                <td>${nombre}</td>
                <td class=oculto>${descripcion}</td>
                <td class=oculto>${saldocantidad}</td>
                <td class=oculto>${saldocosto}</td>
                <td class=oculto>${costopromedio}</td>
                <td>
                    <input id="cantidadInsumo" class="form-control col-3" name="cantidadInsumo" type="text" placeholder="Cantidad de paquetes" autofocus="" value="1">
                </td>
                <td class=" last">
                    <a id ="delete_row${id}" onclick="ordensalida.DeleteInsumo(this)" > <i class="glyphicon glyphicon-trash" onclick="DeleteInsumo(this)"> </i> Eliminar </a>
                </td>
            </tr>
        `);
        //datatable         
        if ( $.fn.dataTable.isDataTable( '#dsOrdenSalida' ) ) {
            var table = $('#dsOrdenSalida').DataTable();
        }
        else 
            $('#dsOrdenSalida').DataTable( {
                columns: [
                    { "width":"0px"},
                    { "width":"0px"},
                    { "width":"35%"},
                    { "width":"0px"},
                    { "width":"0px"},
                    { "width":"0px"},
                    { "width":"0px"},
                    { "width":"35%"},
                    { "width":"30%"}
                ],          
                "paging": false,
                "ordering": false,
                "info": false,
                "searching": false
            } );
    };

    AddTableProducto(id,nombre,costo) {
        $('#tableBody-InsumoProducto').append(`
            <tr id="row"${id}> 
                <td class="itemId" >${id}</td>
                <td>${nombre}</td>
                <td>
                    <input id="cantidadInsumo" class="form-control col-3" name="cantidadInsumo" type="text" placeholder="Cantidad de paquetes" autofocus="" value="1">
                </td>
                <td class=oculto>${costo}</td>
                <td class=" last">
                    <a id ="delete_row${id}" onclick="ordensalida.DeleteInsumo(this)" > <i class="glyphicon glyphicon-trash" onclick="DeleteInsumo(this)"> </i> Eliminar </a>
                </td>
            </tr>
        `);
        //datatable         
        if ( $.fn.dataTable.isDataTable( '#dsOrdenSalida' ) ) {
            var table = $('#dsOrdenSalida').DataTable();
        }
        else 
            $('#dsOrdenSalida').DataTable( {
                columns: [
                    { "width":"35%"},
                    { "width":"35%"},
                    { "width":"33%"},
                ],          
                paging: true,
                search: true
            } );
    };

    DeleteInsumo(btn) {
        var row = btn.parentNode.parentNode;
        row.parentNode.removeChild(row);
    }

    UpdateEventHandler() {
        // 
        ordensalida.id = $(this).parents("tr").find(".itemId").text(); //Class itemId = ID del objeto.
        ordensalida.Read;
    };

    ShowItemData(e) {
        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e);
    
        ordensalida = new OrdenSalida(data.id, data.idproducto, data.producto, data.idusuario, data.usuariorecibe,
        data.usuario, data.usuariorecibe, data.cantidad, data.estado, data.listainsumo);

        $.each(data.listainsumo, function (i, item) {
            $('#tableBody-InsumoProducto').append(`
                <tr id="row"${item.idinsumo}> 
                    <td class="itemId" >${item.idinsumo}</td>
                    <td>${item.nombre}</td>
                    <td>
                        <input id="cantidadInsumo" class="form-control col-3" name="cantidadInsumo" type="text" placeholder="${item.cantidad}" autofocus="" value="1">
                    </td>
                    <td class=" last">
                        <a id ="delete_row${item.id}" onclick="ordensalida.DeleteInsumo(this)" > <i class="glyphicon glyphicon-trash" onclick="DeleteInsumo(this)"> </i> Eliminar </a>
                    </td>
                </tr>
            `);
            //datatable         
            if ( $.fn.dataTable.isDataTable( '#dsOrdenSalida' ) ) {
                var table = $('#dsOrdenSalida').DataTable();
            }
            else 
                $('#dsOrdenSalida').DataTable( {
                    columns: [
                        { "width":"35%"},
                        { "width":"35%"},
                        { "width":"33%"},
                    ],          
                    paging: true,
                    search: true
                } );
        })
        
        // Asigna objeto a controles
        $("#nombre").val(ordensalida.producto);
        $("#cantidad").val(ordensalida.cantidad);
        $("#usuariorecibe").val(ordensalida.usuariorecibe);
    };

    DeleteEventHandler() {
        ordensalida.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
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
                ordensalida.Delete;
            }
        })
    };

    AddUserEventHandler(){
        $("#usuariorecibe").val($(this).parents("tr").find("td:eq(2)").html());
        ordensalida.usuariorecibe = $(this).parents("tr").find("td:eq(1)").html();
        $('#modal-usuariorecibe').modal('toggle');
        $("#estado").focus();
    }

    AddProductoEventHandler(){
        $("#nombre").val($(this).parents("tr").find("td:eq(2)").html());
        ordensalida.idproducto = $(this).parents("tr").find("td:eq(1)").html();
        $('#modal-producto').modal('toggle');
        $("#cantidad").focus();
    }
    /* PENDIENTE */ 
    AddInsumoEventHandler(){
        var id=$(this).parents("tr").find("td:eq(1)").html();
        var codigo=$(this).parents("tr").find("td:eq(2)").html(); 
        var nombre=$(this).parents("tr").find("td:eq(3)").html();
        var descripcion=$(this).parents("tr").find("td:eq(4)").html();
        var saldocantidad=$(this).parents("tr").find("td:eq(5)").html();
        var saldocosto=$(this).parents("tr").find("td:eq(6)").html();
        var costopromedio=$(this).parents("tr").find("td:eq(7)").html();
        var ids_insumos = [];

        if ($(this).is(':checked')) {
            $('#tableBody-OrdenSalida tr').each(function() {
                ids_insumos.push($(this).find('td:eq(0)').html());   
            });
            if (ids_insumos.length==0) {
                ordensalida.AddTableInsumo(id,codigo,nombre,descripcion,saldocantidad,saldocosto,costopromedio);
            }
            else{
                if (ids_insumos.indexOf(id)!=-1) 
                    $('#chk-addinsumo'+id).attr("checked",false);
                else
                    ordensalida.AddTableInsumo(id,codigo,nombre,descripcion,saldocantidad,saldocosto,costopromedio);
            }
        }
    }

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms[0][0]);
        $('#frmOrdenSalida').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                ordensalida.Save;
            return false;
        });

        $('#frmInventarioOrdenSalida').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                ordensalida.Save;
            return false;
        });

        // on form "reset" event
        document.forms[0].onreset = function (e) {
            validator.reset();
        }
    };

    
}

//Class Instance
let ordensalida = new OrdenSalida();