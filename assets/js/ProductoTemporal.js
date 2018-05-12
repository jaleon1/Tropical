class ProductoTemporal {
    // Constructor
constructor(id, idproducto, idusuario, cantidad, estado, insumo) {
        this.id = id || null;
        this.idproducto = idproducto || '';
        this.idusuario = idusuario || '';
        this.cantidad = cantidad || 0;
        this.estado = estado || 0;
        this.insumo = [];
        this.cantidadinsumo = [];
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
        $('#btnProductoTemporal').attr("disabled", "disabled");
        var miAccion = productotemporal.id == null ? 'Create' : 'Update';
        var miAccion = this.id == null ? 'Create' : 'Update';
        this.idproducto = productotemporal.idproducto;
        this.idusuario = "1ed3a48c-3e44-11e8-9ddb-54ee75873a60";
        this.cantidad = $("#cantidad").val();
        this.estado = 1;
        this.insumo = productotemporal.insumo;
        productotemporal.AddCantidadInsumo();
        this.cantidadinsumo = productotemporal.cantidadinsumo;
        //Recorrido datatable para guardar id de insumos
        
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
                $("#idproducto").focus();
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
                swal({
                    //position: 'top-end',
                    type: 'success',
                    title: 'Eliminado!',
                    showConfirmButton: false,
                    timer: 1000
                });
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
        $("#id").val('');
        $("#idproducto").val('');
        $("#idusuario").val('');
        $("#cantidad").val('');
        $("#estado").val('');
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
                    <td class="itemId" >${item.id}</td>
                    <td class="itemId" >${item.idproducto}</td>
                    <td class="itemId" >${item.idusuario}</td>
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
            $('#dsProductoTemporal').DataTable( {
                columns: [
                    { title: "Check" },
                    { title: "ID"},
                    { title: "IdProducto" },
                    { title: "IdUsuario" },
                    { title: "Cantidad" },
                    { title: "Estado" }
                ],          
                paging: true,
                search: true
            } );
    };

    AddTableInsumo(id,nombre) {
        $('#tableBody-InsumoProducto').append(`
            <tr id="row${id}"> 
                <td class="itemId" >${id}</td>
                <td>${nombre}</td>
                <td>
                    <input id="cantidad${id}" class="form-control col-3" name="cantidad" type="text" placeholder="Cantidad de paquetes" autofocus="">
                </td>
                <td class=" last">
                    <a id ="delete_row${id}" class="delete"> <i class="glyphicon glyphicon-trash"> </i> Eliminar </a>
                </td>
            </tr>
        `);
        $("#delete_row"+id).click(productotemporal.DeleteInsumo);
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

    DeleteInsumo(){
        var id=$(this).closest('tr').children('td:first').text();
        var posicion = productotemporal.insumo.indexOf(id);
        productotemporal.insumo.splice(posicion,1);
        $('#row'+id).remove();
    }

    UpdateEventHandler() {
        productotemporal.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
        productotemporal.Read;
    };

    ShowItemData(e) {
        /*************************** LLENAR EL MODAL CON TODA LA INFO Y LOS ARRAYS DE INSUMOS Y CANTIDAD */
        
        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e);
        productotemporal = new ProductoTemporal(data.id, data.idproducto, data.idusuario,
            data.cantidad, data.estado);
        // Asigna objeto a controles
        $("#id").val(productotemporal.id);
        $("#idproducto").val(productotemporal.idproducto);
        $("#idusuario").val(productotemporal.idusuario);
        $("#estado").val(productotemporal.estado);
        $("#cantidad").val(productotemporal.cantidad);
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
    }

    AddInsumoEventHandler(){
        var posicion=null;
        var id=$(this).parents("tr").find("td:eq(1)").html();
        var nombre=$(this).parents("tr").find("td:eq(2)").html();
        if ($(this).is(':checked')) {
            if (productotemporal.insumo.indexOf(id)!=-1){
                $(this).attr("checked",false);
                return false;
            }
            else{
                productotemporal.insumo.push(id);    
                productotemporal.AddTableInsumo(id,nombre);
            }
        }
        else{
            posicion = productotemporal.insumo.indexOf(id);
            productotemporal.insumo.splice(posicion,1);
            $('#row'+id).remove();
        }
    }

    AddCantidadInsumo(){
        for (let i = 0; i < productotemporal.insumo.length; i++) {
            productotemporal.cantidadinsumo[i] = $('#cantidad'+productotemporal.insumo[i]).val();
        }
    }

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms[0][0]);
        $('#frmProductoTemporal').submit(function (e) {
            e.preventDefault();
            // var validatorResult = validator.checkAll(this);
            // if (validatorResult.valid)
                productotemporal.Save;
            /*return false;*/
        });

        // on form "reset" event
        document.forms[0].onreset = function (e) {
            validator.reset();
        }
        
        //datepicker.js
        $('#dpfechaExpiracion').datetimepicker({
            format: 'DD/MM/YYYY'
        });

    };

    
}

//Class Instance
let productotemporal = new ProductoTemporal();