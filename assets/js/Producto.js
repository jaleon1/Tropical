class Producto {
    // Constructor
    constructor(id, codigo, nombre, txtColor, bgColor, nombreAbreviado, descripcion, saldoCantidad, saldoCosto, costoPromedio, precioVenta, tipoProducto, lista) {
        this.id = id || null;        
        this.codigo = codigo || '';
        this.nombre = nombre || '';
        this.txtColor = txtColor || '';
        this.bgColor = bgColor || '';
        this.nombreAbreviado = nombreAbreviado || '';
        this.descripcion = descripcion || '';
        this.saldoCantidad = saldoCantidad || 0;
        this.saldoCosto = saldoCosto || 0;
        this.costoPromedio = costoPromedio || 0;
        this.precioVenta = precioVenta || 0;
        this.tipoProducto = tipoProducto || 0; //1: producto para vender, 0 articulo no vendible.
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

    get ReadAllProductoVenta() {
        var miAccion = "ReadAllProductoVenta";
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
        this.codigo = $("#codigo").val();
        this.nombre = $("#nombre").val();
        this.txtColor = $("#txtColor").val();
        this.bgColor = $("#bgColor").val();
        this.nombreAbreviado = $("#nombreAbreviado").val();
        this.descripcion =  $("#descripcion").val();
        this.saldoCantidad = $("#saldoCantidad").val();
        this.saldoCosto = $("#saldoCosto").val();
        this.costoPromedio = $("#costoPromedio").val();
        this.precioVenta = $("#precioVenta").val();
        this.tipoProducto = $('#tipoProducto option:selected').val();

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
        var miAccion = 'Add';
        // obj
        producto.lista = [];
        $('#tableBody-ArticuloBodega tr').each(function() {
            var objArticulo = new Object();
            objArticulo.idBodega= '22a80c9e-5639-11e8-8242-54ee75873a00'; //id unico bodega principal.
            objArticulo.idProducto= $(this).find('td:eq(0)').html();
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
                    //
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
        $("#codigo").val('');
        $("#nombre").val('');
        $("#txtColor").val('');
        $("#bgColor").val('');
        $("#nombreAbreviado").val('');
        $("#descripcion").val('');
        $("#saldoCantidad").val('');
        $("#saldoCosto").val('');
        $("#costoPromedio").val('');
        $("#precioVenta").val(''); 
        $('#tipoProducto option').prop("selected", false);
        $("#tipoProducto").selectpicker("refresh");
    };

    ShowAll(e) {
        var url;
        url = window.location.href;
        // Limpia el div que contiene la tabla.
        $('#tableBody-Producto').html("");
        // // Carga lista
        var data = JSON.parse(e);

        $.each(data, function (i, item) {
            $('#tableBody-Producto').append(`
                <tr> 
                    <td>
                        <input class="flat" type="checkbox" id="chk-addproducto${item.id}">
                    </td>
                    <td class="itemId">${item.id}</td>
                    <td>${item.codigo}</td>
                    <td>${item.nombre}</td>
                    <td>${item.nombreAbreviado}</td>
                    <td>${item.descripcion}</td>
                    ${document.URL.indexOf("ElaborarProducto.html")>=1 ?                                       
                        `<td class="oculto">${item.saldoCantidad}</td>
                        <td class="oculto">${parseFloat(item.saldoCosto).toFixed(2)}</td>
                        <td class="oculto">${parseFloat(item.costoPromedio).toFixed(2)}</td>
                        <td class="oculto">${parseFloat(item.precioVenta).toFixed(2)}</td>
                        <td class="oculto">${item.esVenta}</td>`
                    :``}
                    ${document.URL.indexOf("InventarioProducto.html")>=1 ?                                       
                        `<td>${item.saldoCantidad}</td>

                        
                        <td>${parseFloat(item.saldoCosto).toFixed(2)}</td>
                        <td>${parseFloat(item.costoPromedio).toFixed(2)}</td>
                        <td>${parseFloat(item.precioVenta).toFixed(2)}</td>
                        <td>${item.esVenta}</td>
                        <td class=" last">
                            <a  id="update${item.id}" data-toggle="modal" data-target=".bs-example-modal-lg" > <i class="glyphicon glyphicon-edit" > </i> Editar </a> | 
                            <a  id="delete${item.id}"> <i class="glyphicon glyphicon-trash"> </i> Eliminar </a>
                        </td>`
                    :``}
                </tr>
            `);
            // event Handler
            $('.update'+item.id).click(producto.UpdateEventHandler);
            $('.delete'+item.id).click(producto.DeleteEventHandler);
            if (document.URL.indexOf("ElaborarProducto.html")!=-1) {
                $('#chk-addproducto'+item.id).change(elaborarProducto.AddProductoEventHandler);
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
        producto = new Producto(data.id, data.codigo, data.nombre, data.txtColor, data.bgColor, data.nombreAbreviado, 
        data.descripcion, data.saldoCantidad, data.saldoCosto, data.costoPromedio, data.precioVenta , data.esVenta);
        // Asigna objeto a controles
        $("#id").val(producto.id);
        $("#codigo").val(producto.codigo);
        $("#nombre").val(producto.nombre);
        $("#txtColor").val(producto.txtColor);
        $("#bgColor").val(producto.bgColor);
        $("#nombreAbreviado").val(producto.nombreAbreviado);
        $("#descripcion").val(producto.descripcion);
        $("#saldoCantidad").val(producto.saldoCantidad);
        $("#saldoCosto").val(parseFloat(producto.saldoCantidad).toFixed(2));
        $("#costoPromedio").val(parseFloat(producto.costoPromedio).toFixed(2));
        $("#precioVenta").val(parseFloat(producto.precioVenta).toFixed(2));
        //$("#tipoProducto").val(producto.tipoProducto);
        $('#tipoProducto option[value=' + producto.tipoProducto + ']').prop("selected", true);
        $("#tipoProducto").selectpicker("refresh");
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
                    <a id ="delete_row${id}" onclick="elaborarProducto.Deleteproducto(this)" > <i class="glyphicon glyphicon-trash" onclick="Deleteproducto(this)"> </i> Eliminar </a>
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

    LoadProducto() {
        if ($("#p_searh").val() != ""){
            producto.codigo = $("#p_searh").val();  //Columna 0 de la fila seleccionda= ID.
            //
            $.ajax({
                type: "POST",
                url: "class/Producto.php",
                data: {
                    action: "ReadByCode",
                    obj: JSON.stringify(producto)
                }
            })
            .done(function (e) {
                producto.ValidateProductoFac(e);
            })
            .fail(function (e) {
                producto.showError(e);
            });
        }
    };

    ValidateProductoFac(e){
        //compara si el articulo ya existe
        // carga lista con datos.
        if(e != "false"){
            var data = JSON.parse(e)[0];
            producto= new Producto(data.id, data.codigo, data.nombre, data.txtColor, data.bgColor, data.nombreAbreviado, data.descripcion, data.saldoCantidad, data.saldoCosto, data.costoPromedio, data.precioVenta, data.tipoProducto, data.lista);
            producto.UltPrd = producto.codigo;
            var repetido = false;
            //
            if(document.getElementById("tbodyItems").rows.length != 0 && data != null){
                $(document.getElementById("tbodyItems").rows).each(function(i,item){
                    if(item.childNodes[0].innerText==producto.codigo){
                        repetido=true;
                        swal({
                            type: 'warning',
                            title: 'Determinación de Precio',
                            text: 'El item ' + producto.codigo + ' ya se encuentra en la lista',
                            showConfirmButton: false,
                            timer: 3000
                        });
                        
                    }     
                });
            }    
            if (repetido==false){
                // showDataProducto(e);
                producto.AgregaProducto();
                producto.ResetSearch();
            }
        }
        else {
            swal({
                type: 'warning',
                title: 'Determinación de Producto',
                text: 'El producto No existe.',
                showConfirmButton: false,
                timer: 3000
            });
            return;
        }
    };

    ResetSearch() {
        $("#p_searh").val('');
    };

    AgregaProducto(){
        var rowNode = t
            .row.add( [producto.id, producto.codigo, producto.nombre, producto.costoPromedio, producto.precioVenta ])
            .draw() 
            .node();     
        //
        $('td:eq(2) input', rowNode).attr({id: ("costo"+producto.id), max:  "9999999999999", min: "1", step:"1", 
            value: parseFloat(producto.costoPromedio).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")
        });
        $('td:eq(3) input', rowNode).attr({id: ("precio"+producto.id), max:  "9999999999999", min: "0", step:"1", value: producto.precioVenta });
    };

    ActualizarPrecios(){
        producto.lista = [];
        $('#tbodyItems tr').each(function(i, item) {
            var objlista = new Object();
            objlista.id= $('#dsItems').dataTable().fnGetData(item)[0]; // id del item.
            objlista.precioVenta= $(this).find('td:eq(3) input').val();
            producto.lista.push(objlista);
        });
        $.ajax({
            type: "POST",
            url: "class/Producto.php",
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
    }

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
    };

}

//Class Instance
let producto = new Producto();