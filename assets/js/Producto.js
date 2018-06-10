class Producto {
    // Constructor
    constructor(id, nombre, codigo, articulo, cantidad, costo, lista) {
        this.id = id || null;
        this.nombre = nombre || '';
        this.codigo = codigo || '';
        this.articulo = articulo || 0; //1: articulo; 0: producto.
        this.cantidad = cantidad || 0;
        this.costo = costo || 0;
        this.lista = lista || [];
    }

    //Getter
    get Read() {
        var miAccion = this.id == null ? 'ReadAll' : 'Read';
        if(miAccion=='ReadAll' && $('#tableBody-Producto').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/Producto.php",
            data: {
                action: miAccion,
                id: this.id
            }
        })
            .done(function (e) {
                producto.Reload(e);
            })
            .fail(function (e) {
                producto.showError(e);
            });
    }

    get ReadArticulo() {
        var miAccion = this.id == null ? 'ReadAllArticulo' : 'ReadArticulo';
        if(miAccion=='ReadAllArticulo' && $('#tableBody-Producto').length==0 )
            return;
        $.ajax({
            type: "POST",
            url: "class/Producto.php",
            data: {
                action: miAccion,
                id: this.id
            }
        })
            .done(function (e) {
                producto.Reload(e);
            })
            .fail(function (e) {
                producto.showError(e);
            });
    }

    get Save() {
        $('#btnProducto').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';
        this.nombre = $("#nombre").val();
        this.codigo = $("#codigo").val();
        // this.cantidad = $("#cantidad").val();
        // this.costo = $("#costo").val();
        this.articulo = $("#articulo")[0].checked;
        $.ajax({
            type: "POST",
            url: "class/Producto.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(producto.showInfo)
            .fail(function (e) {
                producto.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnProducto").removeAttr("disabled")', 1000);
                producto = new Producto();
                producto.ClearCtls();
                producto.Read;
                $("#nombre").focus();
            });
    }

    get AddArticuloBodega() {
        if($('#tableBody-ArticuloBodega tr').length<1){
            swal({
                type: 'error',
                title: 'Datos de los Artículos',
                text: 'Debe agregar artículos a la lista',
                showConfirmButton: false,
                timer: 3000
            });
            return false;
        }
        $('#btnArticulo').attr("disabled", "disabled");
        var miAccion = 'Create';
        // obj
        producto.lista = [];
        $('#tableBody-ArticuloBodega tr').each(function() {
            var objArticulo = new Object();
            objArticulo.idbodega= '22a80c9e-5639-11e8-8242-54ee75873a00'; //id unico bodega principal.
            objArticulo.idproducto= $(this).find('td:eq(0)').html();
            objArticulo.cantidad= $(this).find('td:eq(2) input').val();
            objArticulo.costo= $(this).find('td:eq(3) input').val();
            producto.lista.push(objArticulo);
        });
        $.ajax({
            type: "POST",
            url: "class/ProductosXBodega.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(producto.showInfo)
            .fail(function (e) {
                producto.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnArticulo").removeAttr("disabled")', 1000);
                producto = new Producto();
                // limpia el ds
                $('#tableBody-ArticuloBodega').html("");
                producto.ReadArticulo;
            });
    }  

    get Delete() {
        $.ajax({
            type: "POST",
            url: "class/Producto.php",
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
                producto.showError(e);
            })
            .always(function () {
                producto = new Producto();
                producto.Read;
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

    LimpiaArticulos(){
        $('#tableBody-ArticuloBodega').html("");
    };

    ClearCtls() {
        $("#id").val('');
        $("#nombre").val('');
        $("#codigo").val('');
        $("#articulo")[0].checked=false;     
        // $("#cantidad").val('');
        // $("#costo").val('');
    };

    ShowAll(e) {
        var url;
        url = window.location.href;
        // Limpia el div que contiene la tabla.
        $('#tableBody-Producto').html("");
        // // Carga lista
        var data = JSON.parse(e);
        //style="display: none"
        $.each(data, function (i, item) {
            $('#tableBody-Producto').append(`
                <tr> 
                    <td class="a-center ">
                        <input id="chk-addproducto${item.id}" type="checkbox" class="flat" name="table_records">
                    </td>
                    <td class="itemId" >${item.id}</td>
                    <td>${item.nombre}</td>
                    <td>${item.codigo}</td>
                    ${document.URL.indexOf("Producto.html")>=1 ?                                       
                        `<td class=" last">
                            <a  class="update" data-toggle="modal" data-target=".bs-example-modal-lg" > <i class="glyphicon glyphicon-edit" > </i> Editar </a> | 
                            <a  class="delete"> <i class="glyphicon glyphicon-trash"> </i> Eliminar </a>
                        </td>`
                    :   ``
                    }
                </tr>
            `);
            // event Handler
            $('.update').click(producto.UpdateEventHandler);
            $('.delete').click(producto.DeleteEventHandler);
            if (document.URL.indexOf("ProductoTemporal.html")!=-1) {
                $('#chk-addproducto'+item.id).change(productotemporal.AddProductoEventHandler);
            }
            if (document.URL.indexOf("Articulo.html")!=-1 || url.indexOf("Distribucion.html")!=-1) {
                $('#chk-addproducto'+item.id).change(producto.AddArticuloEventHandler);
            }
        })        
        //datatable         
        if ( $.fn.dataTable.isDataTable( '#dsProducto' ) ) {
            var table = $('#dsProducto').DataTable();
        }
        else 
            $('#dsProducto').DataTable( {
                paging: true,
                search: true
            } );
    };

    UpdateEventHandler() {
        producto.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
        producto.Read;
    };

    ShowItemData(e) {
        // Limpia el controles
        this.ClearCtls();
        // carga objeto.
        var data = JSON.parse(e)[0];
        producto = new Producto(data.id, data.nombre, data.nombre, data.articulo);
            // data.cantidad, data.costo);
        // Asigna objeto a controles
        $("#id").val(producto.id);
        $("#nombre").val(producto.nombre);
        $("#codigo").val(producto.codigo);
        // checkbox
        if(producto.articulo==1){
            $("#articulo")[0].checked=true;
        }
        else {
            $("#articulo")[0].checked=false;
        }
        // $("#cantidad").val(producto.cantidad);
        // $("#costo").val(producto.costo);
    };

    DeleteEventHandler() {
        producto.id = $(this).parents("tr").find(".itemId").text();  //Class itemId = ID del objeto.
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
                producto.Delete;
            }
        })
    };

    AddArticuloEventHandler(){
        var posicion=null;
        var id=$(this).parents("tr").find("td:eq(1)").html();
        var nombre=$(this).parents("tr").find("td:eq(2)").html();
        var codigo=$(this).parents("tr").find("td:eq(3)").html();
        if ($(this).is(':checked')) {
            if (producto.lista.indexOf(id)!=-1){
                $(this).attr("checked",false);
                return false;
            }
            else{
                producto.AddTableArticulo(id,nombre);
            }
        }
        else{
            posicion = producto.lista.indexOf(id);
            producto.lista.splice(posicion,1);
            $('#row'+id).remove();
        }
    };

    AddTableArticulo(id,nombre) {
        $('#tableBody-ArticuloBodega').append(`
            <tr id="row"${id}> 
                <td class="itemId" >${id}</td>
                <td>${nombre}</td>
                <td>
                    <input id="cantidad" class="form-control col-3" name="cantidad" type="text" placeholder="Cantidad de artículos" autofocus="" value="1">
                </td>
                <td>
                    <input id="costo" class="form-control col-3" name="costo" type="text" placeholder="Costo del artículo" autofocus="" value="0">
                </td>
                <td class=" last">
                    <a id ="delete_row${id}" onclick="productotemporal.DeleteInsumo(this)" > <i class="glyphicon glyphicon-trash" onclick="DeleteInsumo(this)"> </i> Eliminar </a>
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

    Init() {
        // validator.js
        var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms["frmProducto"]);
        $('#frmProducto').submit(function (e) {
            e.preventDefault();
            var validatorResult = validator.checkAll(this);
            if (validatorResult.valid)
                producto.Save;
            return false;
        });

        // on form "reset" event
        if($('#frmProducto').length > 0 )
            document.forms["frmProducto"].onreset = function (e) {
                validator.reset();
            }
        
        // datepicker.js
        // $('#dpfechaExpiracion').datetimepicker({
        //     format: 'DD/MM/YYYY'
        // });
    };
}

//Class Instance
let producto = new Producto();