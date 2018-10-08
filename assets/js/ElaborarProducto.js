class ElaborarProducto {
    // Constructor
constructor(numeroOrden, p, idOrdenSalida) {
        this.numeroOrden = numeroOrden || '';
        this.fechaLiquida = this.fechaLiquida || '';
        this.listaProducto = p || [];
        this.idOrdenSalida= idOrdenSalida;
    }

    get Save() {
        /* ACA DEBO DE ACTUALIZAR PRODUCTO CON LAS CANTIDADES */
        if ($('#tableBody-ProductoGenerado tr').length == 0){
            swal({
                type: 'info',
                title: 'Debe agregar los Productos a generar...'                    
            });
            return;
        }

        if ($('#tableBody-InsumosOrdenSalida tr').length == 0){
            swal({
                type: 'info',
                title: 'Debe de ingresar una orden...'                    
            });
            return;
        }
        
        $('#btnAddProductoGenerado').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';
        elaborarProducto.numeroOrden = $("#orden").val();
        elaborarProducto.idOrdenSalida = ordenSalida.id;
        elaborarProducto.fechaLiquida = moment().format("YYYY-MM-DD HH:mm:ss");
        // lista de insumos
        elaborarProducto.listaProducto = [];
        var costoTotalInsumo=0;
        $('#tableBody-InsumosOrdenSalida tr').each(function() {
            costoTotalInsumo+=parseFloat($(this).find('td:eq(6)').html())*parseFloat($(this).find('td:eq(7) input').val());
        });

        $('#tableBody-ProductoGenerado tr').each(function() {
            var objProducto = new Object();
            objProducto.idProducto= $(this).find('td:eq(0)').html();
            objProducto.cantidad= $(this).find('td:eq(10) input').val();
            objProducto.costo= costoTotalInsumo;
            elaborarProducto.listaProducto.push(objProducto);
        });

        $.ajax({
            type: "POST",
            url: "class/ElaborarProducto.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(function(e){
                $('#btnAddProductoGenerado').attr("disabled", false);
                swal({
                    type: 'success',
                    title: 'Número de Orden:' + $("#orden").val(),
                    text: 'Liquidada:',
                    showConfirmButton: true
                });
            })
            .fail(function (e) {
                elaborarProducto.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnProductoTemporal").removeAttr("disabled")', 1000);
                // elaborarProducto = new ElaborarProducto();
                elaborarProducto.ClearCtls();
                // elaborarProducto.Read;
            });
    }

    get Delete() {
        $.ajax({
            type: "POST",
            url: "class/ElaborarProducto.php",
            data: {
                action: 'Delete',
                id: this.id
            }
        })
            .done(function () {
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
                elaborarProducto.showError(e);
            })
            .always(function () {
                elaborarProducto = new ElaborarProducto();
                elaborarProducto.Read;
            });
    }

    AddOrdenSalida(){
        ordenSalida.id = $(this).parents("tr").find(".itemId").text();
        $('#numeroOrden').val($(this).parents("tr").find("td:eq(1)").html());
    }

    Reload(e) {
        if (this.id == null)
            this.ShowAll(e);
        else this.ShowItemData(e);
    };

    // Muestra información en ventana
    showInfo() {
        swal({
            
            type: 'success',
            title: 'Listo!',
            showConfirmButton: false,
            timer: 1000
        });
    };

    // Muestra errores en ventana
    showError(e) {  
        var data = JSON.parse(e.responseText);
        swal({
            type: 'error',
            title: 'Oops...',
            text: 'Algo no está bien (' + data.code + '): ' + data.msg,
            footer: '<a href>Contacte a Soporte Técnico</a>',
        })
    };

    ClearCtls() {
        $("#orden").val('');
        $("#fecha").val('');
        $("#usuarioEntrega").val('');
        $("#usuarioRecibe").val('');
        $("#p_searh").val('');
        $('#tableBody-ProductoGenerado').html("");
        $('#tableBody-InsumosOrdenSalida').html("");
    };

    ShowAll(e) {
        if (url.indexOf("ElaborarProducto.html")!=-1) {
            // Limpia el div que contiene la tabla.
            $('#tableBody-ElaborarProducto').html("");
            // // Carga lista
            var data = JSON.parse(e);
            //style="display: none"
            var saldoCosto="EN PROCESO";
            $.each(data, function (i, item) {
                if (item.saldoCosto=="0") 
                    saldoCosto="EN PROCESO";
                else
                    saldoCosto="TERMINADO";
                $('#tableBody-ElaborarProducto').append(`
                    <tr> 
                        <td class="a-center ">
                            <input id="chkaddorden${item.id}" type="checkbox" class="flat" name="table_records">
                        </td>
                        <td class="itemId">${item.id}</td>
                        <td class="oculto">${item.codigo}</td>
                        <td class="oculto">${item.txtColor}</td>
                        <td class="oculto">${item.bgColor}</td>
                        <td>${item.nombre}</td>
                        <td>${item.nombreAbreviado}</td>
                        <td>${item.descripcion}</td>
                        <td>${item.saldoCantidad}</td>
                        <td>${saldoCosto}</td>
                    </tr>
                `);
                $('#chkaddorden'+item.id).click(elaborarProducto.UpdateCantidadProducto);
            })        
            //datatable         
            if ( $.fn.dataTable.isDataTable( '#dsProductoTemporal' ) )
                var table = $('#dsProductoTemporal').DataTable();
            else 
                $('#dsProductoTemporal').DataTable();    
        }
        // Limpia el div que contiene la tabla.
        $('#tableBody-ElaborarProducto').html("");
        // // Carga lista
        var data = JSON.parse(e);
        //style="display: none"
        var saldoCosto="EN PROCESO";
        $.each(data, function (i, item) {
            if (item.saldoCosto=="0") 
                saldoCosto="EN PROCESO";
            else
                saldoCosto="TERMINADO";
            $('#tableBody-ElaborarProducto').append(`
                <tr> 
                    <td class="itemId">${item.id}</td>
                    <td class="oculto">${item.codigo}</td>
                    <td class="oculto">${item.txtColor}</td>
                    <td class="oculto">${item.bgColor}</td>
                    <td>${item.nombre}</td>
                    <td>${item.nombreAbreviado}</td>
                    <td>${item.descripcion}</td>
                    <td>${item.saldoCantidad}</td>
                    <td>${saldoCosto}</td>
                    <td class=" last">
                        <a id="update${item.id}" class="update" data-toggle="modal" data-target=".bs-example-modal-lg" > <i class="glyphicon glyphicon-edit" > </i> Editar </a> | 
                        <a id="delete${item.id}" class="delete"> <i class="glyphicon glyphicon-trash"> </i> Eliminar </a>
                    </td>
                    <td class="a-center ">
                    <input id="chkterminado${item.id}" type="checkbox" class="flat" name="table_records">
                    </td>
                </tr>
            `);
            $('#update'+item.id).click(elaborarProducto.UpdateEventHandler);
            $('#delete'+item.id).click(elaborarProducto.DeleteEventHandler);
            $('#chkterminado'+item.id).click(elaborarProducto.UpdateCantidadProducto);
    
        })        
        //datatable         
        if ( $.fn.dataTable.isDataTable( '#dsProductoTemporal' ) ) {
            var table = $('#dsProductoTemporal').DataTable();

        }
        else 
            $('#dsProductoTemporal').DataTable();
    };

    AddTableProducto(id,codigo,nombre,nombreAbreviado,descripcion,saldoCantidad,saldoCosto,costoPromedio,precioVenta,esVenta) {
        $('#tableBody-ProductoGenerado').append(`
            <tr id="row"${id}> 
                <td class="itemId" >${id}</td>
                <td class=oculto>${codigo}</td>
                <td>${nombre}</td>
                <td class=oculto>${nombreAbreviado}</td>
                <td class=oculto>${descripcion}</td>
                <td class=oculto>${saldoCantidad}</td>
                <td class=oculto>${saldoCosto}</td>
                <td class=oculto>${costoPromedio}</td>
                <td class=oculto>${precioVenta}</td>
                <td class=oculto>${esVenta}</td>
                <td>
                    <input id="cantidadProducto" class="form-control col-3" name="cantidadProducto" type="text" placeholder="Cantidad de paquetes" autofocus="" value="1">
                </td>
                <td class=" last">
                    <a id ="delete_row${id}" onclick="elaborarProducto.DeleteInsumo(this)" > <i class="glyphicon glyphicon-trash" onclick="DeleteInsumo(this)"> </i> Eliminar </a>
                </td>
            </tr>
        `);
        //datatable         
        if ( $.fn.dataTable.isDataTable( '#dsProductoGenerado' ) ) {
            var table = $('#dsProductoGenerado').DataTable();
        }
        else 
            $('#dsProductoGenerado').DataTable( {
                columns: [
                    { "width":"0%"},
                    { "width":"0%"},
                    { "width":"33%"},
                    { "width":"0%"},
                    { "width":"0%"},
                    { "width":"0%"},
                    { "width":"0%"},
                    { "width":"0%"},
                    { "width":"0%"},
                    { "width":"0%"},
                    { "width":"35%"},
                    { "width":"30%"}
                ],          
                "paging": false,
                "ordering": false,
                "info": false,
                "searching": false
            } );
    };
    
    DeleteInsumo(btn) {
        var row = btn.parentNode.parentNode;
        row.parentNode.removeChild(row);
    }

    UpdateEventHandler() {
        // 
        elaborarProducto.id = $(this).parents("tr").find(".itemId").text(); //Class itemId = ID del objeto.
        elaborarProducto.Read;
    };

    ShowItemData(e) {
        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e);
    
        elaborarProducto = new ElaborarProducto(data.id, data.codigo, data.nombre, data.txtColor, data.bgColor,
        data.nombreAbreviado, data.descripcion, data.saldoCantidad, data.saldoCosto, data.listaProducto);

        $.each(data.listaProducto, function (i, item) {
            $('#tableBody-InsumoProducto').append(`
                <tr id="row"${item.idInsumo}> 
                    <td class="itemId" >${item.idInsumo}</td>
                    <td>${item.nombre}</td>
                    <td>
                        <input id="cantidadInsumo" class="form-control col-3" name="cantidadInsumo" type="text" placeholder="${item.saldoCantidad}" autofocus="" value="1">
                    </td>
                    <td class=" last">
                        <a id ="delete_row${item.id}" onclick="elaborarProducto.DeleteInsumo(this)" > <i class="glyphicon glyphicon-trash" onclick="DeleteInsumo(this)"> </i> Eliminar </a>
                    </td>
                </tr>
            `);
            //datatable         
            if ( $.fn.dataTable.isDataTable( '#dsProductoTemporal' ) ) {
                var table = $('#dsProductoTemporal').DataTable();
            }
            else 
                $('#dsProductoTemporal').DataTable( {
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
        $("#nombre").val(elaborarProducto.nombre);
        $("#saldoCantidad").val(elaborarProducto.saldoCantidad);
        $("#descripcion").val(elaborarProducto.descripcion);
    };

    DeleteEventHandler() {
        elaborarProducto.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
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
                elaborarProducto.Delete;
            }
        })
    };

    AddUserEventHandler(){
        $("#descripcion").val($(this).parents("tr").find("td:eq(2)").html());
        elaborarProducto.bgColor = $(this).parents("tr").find("td:eq(1)").html();
        $('#modal-descripcion').modal('toggle');
        $("#saldoCantidad").focus();
    }
    
    AddProductoEventHandler(id,codigo,nombre,nombreAbreviado,descripcion,saldoCantidad,saldoCosto,costoPromedio,precioVenta,esVenta){
        var ids_productos = [];
        $('#tableBody-ProductoGenerado tr').each(function() {
            ids_productos.push($(this).find('td:eq(0)').html());   
        });
        if (ids_productos.length==0) {
            elaborarProducto.AddTableProducto(id,codigo,nombre,nombreAbreviado,descripcion,saldoCantidad,saldoCosto,costoPromedio,precioVenta,esVenta);
        }
        else{
            if (ids_productos.indexOf(id)!=-1) 
                $('#chk-addproducto'+id).attr("checked",false);
            else
                elaborarProducto.AddTableProducto(id,codigo,nombre,nombreAbreviado,descripcion,saldoCantidad,saldoCosto,costoPromedio,precioVenta,esVenta);
        }
    }

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms[0][0]);
        $('#frmProductoGenerado').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                elaborarProducto.Save;
            return false;
        });

        $('#frmProductoTemporal').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                elaborarProducto.Save;
            return false;
        });

        // on form "reset" event
        document.forms[0].onreset = function (e) {
            validator.reset();
        }
    };
}

//Class Instance
let elaborarProducto = new ElaborarProducto();