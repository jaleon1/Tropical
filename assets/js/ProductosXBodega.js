class ProductoBodega {
    // Constructor
    constructor(id, idBodega, precioVenta, lista) {
        this.id = id || null;
        this.idBodega = idBodega || '';
        this.precioVenta = precioVenta || 0;
        this.lista = lista || [];
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
        var miAccion = this.id == null ?  'ReadAll'  : 'Read';
        if(miAccion=='ReadAll' && $('#tDeterminacion tbody').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/ProductosXBodega.php",
            data: {
                action: miAccion,
                id: this.id,
                // idBodega: this.idBodega no envpia el idBodega, toma el de la sesion.
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
                    //
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
        var t= $('#tDeterminacion').DataTable();
        t.clear();
        var data = JSON.parse(e);
        t.rows.add(data);   
        t.draw();
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
        productobodega.id = $(this).parents("tr").find(".itemId").text() || $(this).find(".itemId").text();           
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
        //
        $("#myModalLabel").html('<h1>' + usuario.nombre + '<h1>' );
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

    setTable(buttons=true){
        $('#tDeterminacion').DataTable({
            responsive: true,
            info: false,                    
            "language": {
                "infoEmpty": "Sin Productos Ingresados",
                "emptyTable": "Sin Productos Ingresados",
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
            columns: [
                {
                    title: "id",
                    data: "id",
                    className: "itemId",                    
                    searchable: false
                },
                { 
                    title: "Tamaño", 
                    data: null,
                    render: function (data, type, row) {                        
                        var fdata='';                        
                        if(row['tamano'] === '1')
                            fdata= 'Grande';
                        else fdata= 'Mediano';
                        return fdata;
                    }                    
                },
                { 
                    title: "precioVenta",                     
                    mRender: function (data, row) {                        
                        return '<input class="cantidad form-control" type="number" min="1" max="9999999999" step="1" style="text-align:right;" precioVenta='+ data +'  value= '+ parseFloat(data).toFixed(2) +' >'
                    },
                    data: "precioVenta"
                },
                {
                    title: "Accion",
                    orderable: false,
                    searchable:false,
                    visible: buttons,
                    className: "buttons",
                    mRender: function () {
                        return '<a class="update" > <i class="glyphicon glyphicon-edit" > </i> Editar </a> | <a class="delete"> <i class="glyphicon glyphicon-trash"> </i> Eliminar </a>'                            
                    }
                }
            ]
        });
    };

    ActualizarPrecios(){
        productobodega.lista = [];
        $('#tDeterminacion tbody tr').each(function(i, item) {
            var objlista = new Object();
            objlista.id= $(item).find('td:eq(0)')[0].textContent;
            objlista.precioVenta= $(this).find('td:eq(2) input').val();
            productobodega.lista.push(objlista);
        });
        $.ajax({
            type: "POST",
            url: "class/ProductosXBodega.php",
            data: {
                action: "ActualizaPrecios",
                obj: JSON.stringify(this)
            }
        })
            .done(producto.showInfo)
            .fail(function (e) {
                producto.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnSubmit").removeAttr("disabled")', 1000);
                producto = new Producto();
                //producto.CleanCtls();
                $("#p_searh").focus();
            });
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