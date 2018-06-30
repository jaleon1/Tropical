class ProductoTemporal {
    // Constructor
constructor(numeroorden, p) {
        this.numeroorden = numeroorden || '';
        this.listaproducto = p || [];
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
        productotemporal.numeroorden = $("#orden").val();
        // lista de insumos
        productotemporal.listaproducto = [];
        var costototalinsumo=0;
        $('#tableBody-InsumosOrdenSalida tr').each(function() {
            costototalinsumo+=parseFloat($(this).find('td:eq(6)').html())*parseFloat($(this).find('td:eq(7) input').val());
        });

        $('#tableBody-ProductoGenerado tr').each(function() {
            var objproduto = new Object();
            objproduto.idproducto= $(this).find('td:eq(0)').html();
            objproduto.cantidad= $(this).find('td:eq(10) input').val();
            objproduto.costo= costototalinsumo;
            productotemporal.listaproducto.push(objproduto);
        });

        $.ajax({
            type: "POST",
            url: "class/ProductoTemporal.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(function(e){
                swal({
                    type: 'success',
                    title: 'Número de Orden:' + $("#orden").val(),
                    text: 'Número de orden de Distribución:',
                    showConfirmButton: true
                });
            })
            .fail(function (e) {
                productotemporal.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnProductoTemporal").removeAttr("disabled")', 1000);
                // productotemporal = new ProductoTemporal();
                productotemporal.ClearCtls();
                // productotemporal.Read;
            });
    }

    get Delete() {
        $.ajax({
            type: "POST",
            url: "class/ProductoTemporal.php",
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
                productotemporal.showError(e);
            })
            .always(function () {
                productotemporal = new ProductoTemporal();
                productotemporal.Read;
            });
    }

    AddOrdenSalida(){
        ordensalida.id = $(this).parents("tr").find(".itemId").text();
        $('#numeroorden').val($(this).parents("tr").find("td:eq(1)").html());
    }

    Reload(e) {
        if (this.id == null)
            this.ShowAll(e);
        else this.ShowItemData(e);
    };

    // Muestra información en ventana
    showInfo() {
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
        $("#usuarioentrega").val('');
        $("#usuariorecibe").val('');
        $("#p_searh").val('');
        $('#tableBody-ProductoGenerado').html("");
        $('#tableBody-InsumosOrdenSalida').html("");
    };

    ShowAll(e) {
        if (url.indexOf("ProductoTemporal.html")!=-1) {
            // Limpia el div que contiene la tabla.
            $('#tableBody-ProductoTemporal').html("");
            // // Carga lista
            var data = JSON.parse(e);
            //style="display: none"
            var saldocosto="EN PROCESO";
            $.each(data, function (i, item) {
                if (item.saldocosto=="0") 
                    saldocosto="EN PROCESO";
                else
                    saldocosto="TERMINADO";
                $('#tableBody-ProductoTemporal').append(`
                    <tr> 
                        <td class="a-center ">
                            <input id="chkaddorden${item.id}" type="checkbox" class="flat" name="table_records">
                        </td>
                        <td class="itemId">${item.id}</td>
                        <td class="oculto">${item.codigo}</td>
                        <td class="oculto">${item.txtcolor}</td>
                        <td class="oculto">${item.bgcolor}</td>
                        <td>${item.nombre}</td>
                        <td>${item.nombreabreviado}</td>
                        <td>${item.descripcion}</td>
                        <td>${item.saldocantidad}</td>
                        <td>${saldocosto}</td>
                    </tr>
                `);
                $('#chkaddorden'+item.id).click(productotemporal.UpdateCantidadProducto);
            })        
            //datatable         
            if ( $.fn.dataTable.isDataTable( '#dsProductoTemporal' ) )
                var table = $('#dsProductoTemporal').DataTable();
            else 
                $('#dsProductoTemporal').DataTable();    
        }
        // Limpia el div que contiene la tabla.
        $('#tableBody-ProductoTemporal').html("");
        // // Carga lista
        var data = JSON.parse(e);
        //style="display: none"
        var saldocosto="EN PROCESO";
        $.each(data, function (i, item) {
            if (item.saldocosto=="0") 
                saldocosto="EN PROCESO";
            else
                saldocosto="TERMINADO";
            $('#tableBody-ProductoTemporal').append(`
                <tr> 
                    <td class="itemId">${item.id}</td>
                    <td class="oculto">${item.codigo}</td>
                    <td class="oculto">${item.txtcolor}</td>
                    <td class="oculto">${item.bgcolor}</td>
                    <td>${item.nombre}</td>
                    <td>${item.nombreabreviado}</td>
                    <td>${item.descripcion}</td>
                    <td>${item.saldocantidad}</td>
                    <td>${saldocosto}</td>
                    <td class=" last">
                        <a id="update${item.id}" class="update" data-toggle="modal" data-target=".bs-example-modal-lg" > <i class="glyphicon glyphicon-edit" > </i> Editar </a> | 
                        <a id="delete${item.id}" class="delete"> <i class="glyphicon glyphicon-trash"> </i> Eliminar </a>
                    </td>
                    <td class="a-center ">
                    <input id="chkterminado${item.id}" type="checkbox" class="flat" name="table_records">
                    </td>
                </tr>
            `);
            $('#update'+item.id).click(productotemporal.UpdateEventHandler);
            $('#delete'+item.id).click(productotemporal.DeleteEventHandler);
            $('#chkterminado'+item.id).click(productotemporal.UpdateCantidadProducto);
    
        })        
        //datatable         
        if ( $.fn.dataTable.isDataTable( '#dsProductoTemporal' ) ) {
            var table = $('#dsProductoTemporal').DataTable();

        }
        else 
            $('#dsProductoTemporal').DataTable();
    };

    AddTableProducto(id,codigo,nombre,nombreabreviado,descripcion,saldocantidad,saldocosto,costopromedio,precioventa,esventa) {
        $('#tableBody-ProductoGenerado').append(`
            <tr id="row"${id}> 
                <td class="itemId" >${id}</td>
                <td class=oculto>${codigo}</td>
                <td>${nombre}</td>
                <td class=oculto>${nombreabreviado}</td>
                <td class=oculto>${descripcion}</td>
                <td class=oculto>${saldocantidad}</td>
                <td class=oculto>${saldocosto}</td>
                <td class=oculto>${costopromedio}</td>
                <td class=oculto>${precioventa}</td>
                <td class=oculto>${esventa}</td>
                <td>
                    <input id="cantidadProducto" class="form-control col-3" name="cantidadProducto" type="text" placeholder="Cantidad de paquetes" autofocus="" value="1">
                </td>
                <td class=" last">
                    <a id ="delete_row${id}" onclick="productotemporal.DeleteInsumo(this)" > <i class="glyphicon glyphicon-trash" onclick="DeleteInsumo(this)"> </i> Eliminar </a>
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
        productotemporal.id = $(this).parents("tr").find(".itemId").text(); //Class itemId = ID del objeto.
        productotemporal.Read;
    };

    ShowItemData(e) {
        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e);
    
        productotemporal = new ProductoTemporal(data.id, data.codigo, data.nombre, data.txtcolor, data.bgcolor,
        data.nombreabreviado, data.descripcion, data.saldocantidad, data.saldocosto, data.listaproducto);

        $.each(data.listaproducto, function (i, item) {
            $('#tableBody-InsumoProducto').append(`
                <tr id="row"${item.idinsumo}> 
                    <td class="itemId" >${item.idinsumo}</td>
                    <td>${item.nombre}</td>
                    <td>
                        <input id="cantidadInsumo" class="form-control col-3" name="cantidadInsumo" type="text" placeholder="${item.saldocantidad}" autofocus="" value="1">
                    </td>
                    <td class=" last">
                        <a id ="delete_row${item.id}" onclick="productotemporal.DeleteInsumo(this)" > <i class="glyphicon glyphicon-trash" onclick="DeleteInsumo(this)"> </i> Eliminar </a>
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
        $("#nombre").val(productotemporal.nombre);
        $("#saldocantidad").val(productotemporal.saldocantidad);
        $("#descripcion").val(productotemporal.descripcion);
    };

    DeleteEventHandler() {
        productotemporal.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
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
                productotemporal.Delete;
            }
        })
    };

    AddUserEventHandler(){
        $("#descripcion").val($(this).parents("tr").find("td:eq(2)").html());
        productotemporal.bgcolor = $(this).parents("tr").find("td:eq(1)").html();
        $('#modal-descripcion').modal('toggle');
        $("#saldocantidad").focus();
    }
    
    AddProductoEventHandler(){
        var id=$(this).parents("tr").find("td:eq(1)").html();
        var codigo=$(this).parents("tr").find("td:eq(2)").html();
        var nombre=$(this).parents("tr").find("td:eq(3)").html();
        var nombreabreviado=$(this).parents("tr").find("td:eq(4)").html();
        var descripcion=$(this).parents("tr").find("td:eq(5)").html();
        var saldocantidad=$(this).parents("tr").find("td:eq(6)").html();
        var saldocosto=$(this).parents("tr").find("td:eq(7)").html();
        var costopromedio=$(this).parents("tr").find("td:eq(8)").html();
        var precioventa=$(this).parents("tr").find("td:eq(9)").html();
        var esventa=$(this).parents("tr").find("td:eq(10)").html();
        
        var ids_productos = [];

        if ($(this).is(':checked')) {
            $('#tableBody-ProductoGenerado tr').each(function() {
                ids_productos.push($(this).find('td:eq(0)').html());   
            });
            if (ids_productos.length==0) {
                productotemporal.AddTableProducto(id,codigo,nombre,nombreabreviado,descripcion,saldocantidad,saldocosto,costopromedio,precioventa,esventa);
            }
            else{
                if (ids_productos.indexOf(id)!=-1) 
                    $('#chk-addproducto'+id).attr("checked",false);
                else
                    productotemporal.AddTableProducto(id,codigo,nombre,nombreabreviado,descripcion,saldocantidad,saldocosto,costopromedio,precioventa,esventa);
            }
        }
    }

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms[0][0]);
        $('#frmProductoGenerado').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                productotemporal.Save;
            return false;
        });

        $('#frmProductoTemporal').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                productotemporal.Save;
            return false;
        });

        // on form "reset" event
        document.forms[0].onreset = function (e) {
            validator.reset();
        }
    };
}

//Class Instance
let productotemporal = new ProductoTemporal();