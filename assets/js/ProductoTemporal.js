class ProductoTemporal {
    // Constructor
constructor(id, idproducto,  cantidad, estado, fecha, i) {
        this.id = id || null;
        this.idproducto = idproducto || '';
        this.cantidad = cantidad || 0;
        this.estado = estado || 0;
        this.fecha = fecha || null;
        this.listainsumo = i || [];
    }

    //Getter
    get Read() {
        var miAccion = this.id == null ? 'ReadAll' : 'Read';
        if(miAccion=='ReadAll' && $('#tableBody-ProductoTemporal').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/ProductoTemporal.php",
            data: {
                action: miAccion,
                id: this.id
            }
        })
            .done(function (e) {
                productotemporal.Reload(e);
            })
            .fail(function (e) {
                productotemporal.showError(e);
            });
    }

    get Save() {
        if ($('#tableBody-InsumoProducto tr').length == 0){
            swal({
                type: 'info',
                title: 'Debe agregar los Insumos del Producto...'                    
            });
            return;
        }
        $('#btnProductoTemporal').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';
        this.idproducto = productotemporal.idproducto;
        this.cantidad = $("#cantidad").val();
        this.estado = 1;
        // lista de insumos

        $('#tableBody-InsumoProducto tr').each(function() {
            var objInsumo = new Object();
            objInsumo. id= $(this).find('td:eq(0)').html();
            objInsumo. cantidad= $(this).find('td:eq(2) input').val();
            productotemporal.listainsumo.push(objInsumo);
        });
        $.ajax({
            type: "POST",
            url: "class/ProductoTemporal.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(productotemporal.showInfo)
            .fail(function (e) {
                productotemporal.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnProductoTemporal").removeAttr("disabled")', 1000);
                productotemporal = new ProductoTemporal();
                productotemporal.ClearCtls();
                productotemporal.Read;
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
        $("#cantidad").val('');
        $("#nombre").val('');
        //datatable.
        $('#tableBody-InsumoProducto').html("");
    };

    ShowAll(e) {
        // Limpia el div que contiene la tabla.
        $('#tableBody-ProductoTemporal').html("");
        // // Carga lista
        var data = JSON.parse(e);
        //style="display: none"
        var estado="EN PROCESO";
        $.each(data, function (i, item) {
            if (item.estado=="1") 
                estado="EN PROCESO";
            else
                estado="TERMINADO";
            $('#tableBody-ProductoTemporal').append(`
                <tr> 
                    <td class="a-center ">
                        <input type="checkbox" class="flat" name="table_records">
                    </td>
                    <td class="itemId">${item.id}</td>
                    <td>${item.idproducto}</td>
                    <td>${item.idusuario}</td>
                    <td>${item.producto}</td>
                    <td>${item.usuario}</td>
                    <td>${item.cantidad}</td>
                    <td>${estado}</td>
                    <td class=" last">
                        <a id="update${item.id}" class="update" data-toggle="modal" data-target=".bs-example-modal-lg" > <i class="glyphicon glyphicon-edit" > </i> Editar </a> | 
                        <a id="delete${item.id}" class="delete"> <i class="glyphicon glyphicon-trash"> </i> Eliminar </a>
                    </td>
                </tr>
            `);
            $('#update'+item.id).click(productotemporal.UpdateEventHandler);
            $('#delete'+item.id).click(productotemporal.DeleteEventHandler);

        })        
        //datatable         
        if ( $.fn.dataTable.isDataTable( '#dsProductoTemporal' ) ) {
            var table = $('#dsProductoTemporal').DataTable();

        }
        else 
            $('#dsProductoTemporal').DataTable( 
            //     {
            //     columns: [
            //         { title: "Check" },
            //         { title: "ID"},
            //         { title: "IdProducto" },
            //         { title: "IdUsuario" },
            //         { title: "Cantidad" },
            //         { title: "Estado" }
            //     ],          
            //     paging: true,
            //     search: true
            // }
         );
    };

    AddTableInsumo(id,nombre) {
        $('#tableBody-InsumoProducto').append(`
            <tr id="row"${id}> 
                <td class="itemId" >${id}</td>
                <td>${nombre}</td>
                <td>
                    <input id="cantidadInsumo" class="form-control col-3" name="cantidadInsumo" type="text" placeholder="Cantidad de paquetes" autofocus="" value="1">
                </td>
                <td class=" last">
                    <a id ="delete_row${id}" onclick="productotemporal.DeleteInsumo(this)" > <i class="glyphicon glyphicon-trash" onclick="DeleteInsumo(this)"> </i> Eliminar </a>
                </td>
            </tr>
        `);
        //datatable         
        if ( $.fn.dataTable.isDataTable( '#dsProductoTemporal' ) ) {
            var table = $('#dsProductoTemporal').DataTable();
        }
        else 
            $('#dsProductoTemporal').DataTable( {
                // columns: [
                //     { title: "ID"},
                //     { title: "Nombre" },
                //     { title: "Cantidad" },
                //     { title: "Acción"}
                // ],
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
        productotemporal.id = $(this).parents("tr").find(".itemId").text(); //Class itemId = ID del objeto.
        productotemporal.Read;
    };

    ShowItemData(e) {
        /*************************** LLENAR EL MODAL CON TODA LA INFO Y LOS ARRAYS DE INSUMOS Y CANTIDAD */

        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e);
        // productotemporal = new ProductoTemporal(data[0].id, data[0].idproducto, data[0].producto, data[0].idusuario,
        //     data[0].usuario,data[0].cantidad, data[0].estado, data.insumo, data.cantidadinsumo);
        
        // Asigna objeto a controles
        // $("#id").val(productotemporal.id);
        $("#nombre").val(data[0].producto);
        // $("#idusuario").val(productotemporal.usuario);
        // $("#estado").val(productotemporal.estado);
        $("#cantidad").val(data[0].cantidad);
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

    AddProductoEventHandler(){
        $("#nombre").val($(this).parents("tr").find("td:eq(2)").html());
        productotemporal.idproducto = $(this).parents("tr").find("td:eq(1)").html();
        $('#modal-producto').modal('toggle');
        $("#cantidad").focus();
    }

    AddInsumoEventHandler(){
        var posicion=null;
        var id=$(this).parents("tr").find("td:eq(1)").html();
        var nombre=$(this).parents("tr").find("td:eq(2)").html();
        if ($(this).is(':checked')) {
            if (productotemporal.listainsumo.indexOf(id)!=-1){
                $(this).attr("checked",false);
                return false;
            }
            else{
                // productotemporal.listainsumo.push(id);
                productotemporal.AddTableInsumo(id,nombre);
            }
        }
        else{
            posicion = productotemporal.listainsumo.indexOf(id);
            productotemporal.listainsumo.splice(posicion,1);
            $('#row'+id).remove();
        }
    }

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms[0][0]);
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
        
        //datepicker.js
//         $('#dpfechaExpiracion').datetimepicker({
//             format: 'DD/MM/YYYY'
//         });

    };

    
}

//Class Instance
let productotemporal = new ProductoTemporal();