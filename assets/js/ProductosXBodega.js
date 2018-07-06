class ProductoBodega {
    // Constructor
    constructor(id, idBodega, idProducto, producto, cantidad, costo, lista) {
        this.id = id || null;
        this.idBodega = idBodega || '';
        this.idProducto = idProducto || '';
        this.producto = producto || '';
        this.cantidad = cantidad || 0;
        this.costo = costo || 0;
        this.lista = lista || [];
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
                idBodega: this.idBodega
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
                productobodega.LimpiaLista();
            });
    }

    get Add() {
        $('#btnProductosXBodega').attr("disabled", "disabled");
        var miAccion = 'Add';
        // obj
        productobodega.lista = [];
        $('#tableBody-listaProducto tr').each(function() {
            var objlista = new Object();
            objlista.idBodega= bodega.id; //bodega seleccionada en el modal.
            objlista.id= $(this).find('td:eq(0)').html(); //id del producto seleccionado para mover.
            objlista.idProducto= $(this).find('td:eq(1)').html();
            objlista.cantidad= $(this).find('td:eq(3) input').val();
            objlista.costo= $(this).find('td:eq(4) input').val();
            productobodega.lista.push(objlista);
        });
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
                productobodega.LimpiaLista();
            });
    }
  
    SaveCantidad(idProductoTemporal) {
        var miAccion = this.id == null ? 'Create' : 'Update';
        $.ajax({
            type: "POST",
            url: "class/ProductosXBodega.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this),
                idProductoTemporal: idProductoTemporal
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
  
  
    get UpdateValue() {
        $('#btnCantidadCosto').attr("disabled", "disabled");
        var miAccion = 'Update';
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
                setTimeout('$("#btnCantidadCosto").removeAttr("disabled")', 1000);
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

    LimpiaLista(){
        $('#tableBody-listaProducto').html("");
        //bodega
        $("#nombre").val('');
        $("#descripcion").val('');
        $("#tipo").val('');
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
                <tr class='trproducto'> 
                    <td class="a-center ">
                        <input id="chk-addproducto${item.id}" type="checkbox" class="flat" name="table_records">
                    </td>
                    <td class="itemId" >${item.id}</td>
                    <td class="itemId" >${item.idProducto}</td>
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
            $('#delete'+item.id).click(productobodega.DeleteEventHandler);
            if (document.URL.indexOf("Distribucion.html")!=-1) {
                $('#chk-addproducto'+item.id).change(productobodega.AddProductoEventHandler);
                //$('.trproducto').dblclick(productobodega.AddProductoEventHandler);
            }
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
                        // ,visible: false
                    },
                    { title: "Producto" },
                    { title: "Cantidad" },
                    { title: "Costo" },
                    { title: "Action" }
                ],
                paging: true,
                search: true
            });
        // agregar / editar producto temporal
        $('#btnAddCantidadCosto').click(productobodega.AddEventHandler);
    };

    AddProductoEventHandler(){
        var posicion=null;
        productobodega.id= $(this).parents("tr").find("td:eq(1)").html();
        productobodega.idProducto=$(this).parents("tr").find("td:eq(2)").html();
        productobodega.producto=$(this).parents("tr").find("td:eq(3)").html();
        productobodega.cantidad= $(this).parents("tr").find("td:eq(4)").html()
        productobodega.costo= $(this).parents("tr").find("td:eq(5)").html();  
        //$(this).find('td:eq(0)').checked= true;
        if ($(this).is(':checked')) {
            if (productobodega.lista.indexOf(productobodega.id)!=-1){
                $(this).attr("checked",false);
                return false;
            }
            else{
                productobodega.AddTableProducto(productobodega.id,productobodega.producto);
            }
        }
        else{
            posicion = productobodega.lista.indexOf(productobodega.id);
            productobodega.lista.splice(posicion,1);
            $('#row'+productobodega.id).remove();
        }
    };

    AddTableProducto() {
        $('#tableBody-listaProducto').append(`
            <tr id="row"${productobodega.id}> 
                <td class="itemId" >${productobodega.id}</td>
                <td class="itemId" >${productobodega.idProducto}</td>
                <td>${ productobodega.producto}</td>
                <td>
                    <input id="cantidad" class="form-control col-3" name="cantidad" type="number" placeholder="Cantidad de artículos" autofocus="" data-validate-minmax="1,${productobodega.cantidad}" value="1">
                </td>
                <td>
                    <input id="costo" class="form-control col-3" name="costo" readonly type="text" placeholder="Costo del artículo" autofocus="" value="${ productobodega.costo}">
                </td>
                <td class=" last">
                    <a id ="delete_row${productobodega.id}" onclick="elaborarProducto.DeleteInsumo(this)" > <i class="glyphicon glyphicon-trash" onclick="DeleteInsumo(this)"> </i> Eliminar </a>
                </td>
            </tr>
        `);
        //datatable         
        if ( $.fn.dataTable.isDataTable( '#dsArticulo' ) ) {
            var table = $('#dsArticulo').DataTable();
        }
        else 
            $('#dsArticulo').DataTable( {
                columns: [
                    { "width":"40%"},
                    { "width":"25%"},
                    { "width":"25%"},
                    { "width":"10%"}
                ],          
                paging: true,
                search: true
            } );
    };

    AddEventHandler() {
        // abre ventana para agregar/editar producto/articulo.        
        //productobodega.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.        
        $('#editarnombreproducto').text($('#productonombre').val());
        $('#costoproductoagregar').val($('#costo').val());
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
        productobodega = new ProductoBodega(data.id, data.idBodega, data.idProducto, data.producto, data.cantidad, data.costo);
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
        if($('#frmProductosXBodega').length > 0 )
            document.forms["frmProductosXBodega"].onreset = function (e) {
                validator.reset();
            }

        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms["frmCantidadCostoxProducto"]);
        $('#frmCantidadCostoxProducto').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                productobodega.Save;
            return false;
        });

        // on form "reset" event
        if($('#frmCantidadCostoxProducto').length > 0 )
            document.forms["frmCantidadCostoxProducto"].onreset = function (e) {
                validator.reset();
            }
    };
}

//Class Instance
let productobodega = new ProductoBodega();