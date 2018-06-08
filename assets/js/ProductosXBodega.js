class ProductoBodega {
    // Constructor
    constructor(id, idbodega, idproducto, producto, cantidad, costo) {
        this.id = id || null;
        this.idbodega = idbodega || '';
        this.idproducto = idproducto || '';
        this.producto = producto || '';
        this.cantidad = cantidad || 0;
        this.costo = costo || 0;
    }

    //Getter
    get Read() {
        var miAccion = this.id == null ?  'ReadAll'  : 'Read';
        if(miAccion=='ReadAll' && $('#tableBody-ProductoBodega').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/ProductosXBodega.php",
            data: {
                action: miAccion,
                id: this.id,
                idbodega: this.idbodega
            }
        })
            .done(function (e) {
                productobodega.Reload(e);
            })
            .fail(function (e) {
                productobodega.showError(e);
            });
    }

    get Save() {
        $('#btnProductosXBodega').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';
        this.cantidad = $("#cantidad").val();
        this.costo = $("#costo").val();
        $.ajax({
            type: "POST",
            url: "class/ProductosXBodega.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(productobodega.showInfo)
            .fail(function (e) {
                productobodega.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnProductosXBodega").removeAttr("disabled")', 1000);
                productobodega = new ProductoBodega();
                productobodega.ClearCtls();
                productobodega.Read;
            });
    }

    SaveCantidad(idproductotemporal) {
        var miAccion = this.id == null ? 'Create' : 'Update';
        $.ajax({
            type: "POST",
            url: "class/ProductosXBodega.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this),
                idproductotemporal: idproductotemporal
            }
        })
            .done(productobodega.showInfo)
            .fail(function (e) {
                productobodega.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnProductosXBodega").removeAttr("disabled")', 1000);
                productobodega = new ProductoBodega();
                productobodega.ClearCtls();
                productobodega.Read;
            });
    }

    get Delete() {
        $.ajax({
            type: "POST",
            url: "class/ProductosXBodega.php",
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
                productobodega.showError(e);
            })
            .always(function () {
                productobodega = new ProductoBodega();
                productobodega.Read;
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
        $("#producto").val('');
        $("#cantidad").val('');
        $("#costo").val('');
    };

    ShowAll(e) {
        // Limpia el div que contiene la tabla.
        $('#tableBody-ProductoBodega').html("");
        // Carga lista
        var data = JSON.parse(e);
        //style="display: none"
        $.each(data, function (i, item) {
            $('#tableBody-ProductoBodega').append(`
                <tr> 
                    <td class="a-center ">
                        <input type="checkbox" class="flat" name="table_records">
                    </td>
                    <td class="itemId" >${item.id}</td>
                    <td>${item.producto}</td>
                    <td>${item.cantidad}</td>
                    <td>${item.costo}</td>
                    <td class=" last">
                        <a id="update${item.id}" data-toggle="modal" data-target=".bs-ProductoCantidad-modal-lg" > <i class="glyphicon glyphicon-edit" > </i> Editar |</a>                         
                        <a id="delete${item.id}"> <i class="glyphicon glyphicon-trash"> </i> Eliminar </a>
                    </td>
                </tr>
            `);
            $('#update'+item.id).click(productobodega.UpdateEventHandler);
            //$('#add'+item.id).click(productobodega.AddEventHandler);  abre ventana de agregar producto temporal.
            $('#delete'+item.id).click(productobodega.DeleteEventHandler);
        })
        //datatable         
        if ($.fn.dataTable.isDataTable('#dsProducto')) {
            var table = $('#dsProducto').DataTable();
        }
        else
            $('#dsProducto').DataTable({
                columns: [
                    { title: "Check" },
                    {
                        title: "ID"
                        ,visible: false
                    },
                    { title: "Producto" },
                    { title: "Cantidad" },
                    { title: "Costo" },
                    { title: "Action" }
                ],
                paging: true,
                search: true
            });
    };

    AddEventHandler() {
        // abre ventana para agregar producto temportal.
        // productobodega.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.        
    };

    UpdateEventHandler() {
        productobodega.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
        // abre modal para editar la cantidad.
        productobodega.Read;
    };

    ShowItemData(e) {
        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e)[0];
        productobodega = new ProductoBodega(data.id, data.idbodega, data.idproducto, data.producto, data.cantidad, data.costo);
        // Asigna objeto a controles
        //$("#id").val(productobodega.id);
        $("#productonombre").val(productobodega.producto);
        $("#cantidad").val(productobodega.cantidad);
        $("#costo").val(productobodega.costo);
    };

    DeleteEventHandler() {
        productobodega.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
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
                productobodega.Delete;
            }
        })
    };

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms["frmProductosXBodega"]);
        $('#frmProductosXBodega').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                productobodega.Save;
            return false;
        });

        // on form "reset" event
        document.forms["frmProductosXBodega"].onreset = function (e) {
            validator.reset();
        }

    };
}

//Class Instance
let productobodega = new ProductoBodega();