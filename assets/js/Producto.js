class Producto {
    // Constructor
    constructor(id, codigo, nombre, txtColor, bgColor, nombreAbreviado, descripcion, saldoCantidad, saldoCosto, costoPromedio, precioVenta, tipoProducto, lista, tablaproducto) {
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
        this.tablaproducto;
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

    get ReadAllPrdVenta() {
        var miAccion = "ReadAllPrdVenta";
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
                $("#codigo").focus();
                producto.ValorDefault();
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
            .done(function (e) {
                var data = JSON.parse(e);
                if (data == 0){
                    swal({
                        type: 'success',
                        title: 'Eliminado!',
                        showConfirmButton: false,
                        timer: 1000
                    });}
                else if (data.status == 1) {
                    swal({
                        type: 'error',
                        title: 'No es posible eliminar...',
                        text: 'El registro que intenta eliminar ya se ecnuentra liquidado'                        
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
        $("#saldoCantidad").val('0');
        $("#saldoCosto").val('0');
        $("#costoPromedio").val('0');
        $("#precioVenta").val('0'); 
        $('#tipoProducto option').prop("selected", false);
        $("#tipoProducto").selectpicker("refresh");
    };

    ShowAll(e) {
        var data = JSON.parse(e);

        $.each(data, function (i, item) {
            if (item.esVenta=="0") 
                item.esVenta="ARTICULO";
            if (item.esVenta=="1") 
                item.esVenta="SABOR";
            if (item.esVenta=="2") 
                item.esVenta="TOPPING";
            item.saldoCosto = "¢"+(parseFloat(item.saldoCosto).toFixed(2)).toString();
            item.costoPromedio = "¢"+(parseFloat(item.costoPromedio).toFixed(2)).toString();
            item.precioVenta = "¢"+(parseFloat(item.precioVenta).toFixed(2)).toString();
        });

        if (document.URL.indexOf("ElaborarProducto.html")!=-1){
            this.tablaproducto = $('#dsProducto').DataTable( {
                responsive: true,
                destroy: true,
                data: data,
                order: [[ 1, "asc" ]],                        
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
                columnDefs: [{className: "text-right", "targets": [5]}],
                columns: [
                    {
                        title:"ID",
                        data:"id",
                        className:"itemId",                    
                        width:"auto"},
                    {
                        title:"CODIGO",
                        data:"codigo",
                        width:"auto"},
                    {
                        title:"NOMBRE",
                        data:"nombre",
                        width:"auto"},
                    {
                        title:"ABREVIATURA",
                        data:"nombreAbreviado",
                        width:"auto"},
                    {
                        title:"DESCRIPCION",
                        data:"descripcion",
                        width:"auto"},
                    {
                        title:"SALDO CANTIDAD",
                        data:"saldoCantidad",
                        width:"auto"},
                    {
                        title:"SALDO COSTO",
                        data:"saldoCosto",
                        visible:false},
                    {
                        title:"COSTO PROMEDIO",
                        data:"costoPromedio",
                        visible:false},
                    {
                        title:"Precio VENTA",
                        data:"precioVenta",
                        visible:false},
                    {
                        title:"TIPO",
                        data:"esVenta",
                        width:"auto"},
                    {
                        title:"ACCIÓN",
                        orderable: false,
                        searchable:false,
                        width: '5%',
                        mRender: function () {
                            return '<a class="update" style="cursor: pointer;"> <i class="glyphicon glyphicon-edit" > </i> Editar </a> | '+
                                    '<a class="delete" style="cursor: pointer;"> <i class="glyphicon glyphicon-trash"> </i> Eliminar </a>' 
                        },
                        visible:false}
                ]
            });
            $( document ).on( 'click', '#dsProducto tbody tr', producto.AddProducto);
        }
        if (document.URL.indexOf("InventarioProducto.html")!=-1){
            this.tablaproducto = $('#dsProducto').DataTable( {
                responsive: true,
                destroy: true,
                data: data,
                order: [[ 1, "asc" ]],        
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
                columnDefs: [{className: "text-right", "targets": [5,6,7,8]}],
                columns: [
                    {
                        title:"ID",
                        data:"id",
                        className:"itemId",                    
                        width:"auto"},
                    {
                        title:"CODIGO",
                        data:"codigo",
                        width:"auto"},
                    {
                        title:"NOMBRE",
                        data:"nombre",
                        width:"auto"},
                    {
                        title:"ABREVIATURA",
                        data:"nombreAbreviado",
                        width:"auto"},
                    {
                        title:"DESCRIPCION",
                        data:"descripcion",
                        width:"auto"},
                    {
                        title:"SALDO CANTIDAD",
                        data:"saldoCantidad",
                        width:"auto"},
                    {
                        title:"SALDO COSTO",
                        data:"saldoCosto",
                        width:"auto"},
                    {
                        title:"COSTO PROMEDIO",
                        data:"costoPromedio",
                        width:"auto"},
                    {
                        title:"Precio VENTA",
                        data:"precioVenta",
                        width:"auto"},
                    {
                        title:"TIPO",
                        data:"esVenta",
                        width:"auto"},
                    {
                        title:"ACCIÓN",
                        orderable: false,
                        searchable:false,
                        className: 'buttons',
                        mRender: function () {
                            return '<a class="delete" style="cursor: pointer;"> <i class="glyphicon glyphicon-trash"> </i> </a>' 
                        },
                        width:"5%"}
                ]
            });
            $( document ).on( 'click', '.delete', producto.DeleteEventHandler);
            $( document ).on( 'click', '#dsProducto tbody tr td:not(.buttons)', producto.UpdateEventHandler);
        }
    };

    AddProducto(){
        var id=$(this).find("td:eq(0)").html();
        var codigo=$(this).find("td:eq(1)").html();
        var nombre=$(this).find("td:eq(2)").html();
        var nombreAbreviado=$(this).find("td:eq(3)").html();
        var descripcion=$(this).find("td:eq(4)").html();
        var saldoCantidad=$(this).find("td:eq(5)").html();
        var saldoCosto = producto.tablaproducto.row(this).data()[8];
        var costoPromedio = producto.tablaproducto.row(this).data()[9];
        var precioVenta = producto.tablaproducto.row(this).data()[10];
        if ($(this).find("td:eq(9)").html()=="SABOR") 
            var esVenta="1";
        else
            var esVenta="2";
        elaborarProducto.AddProductoEventHandler(id,codigo,nombre,nombreAbreviado,descripcion,saldoCantidad,saldoCosto,costoPromedio,precioVenta,esVenta);
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
        // producto = new Producto(data.id, data.codigo, data.nombre, data.txtColor, data.bgColor, data.nombreAbreviado, 
        // data.descripcion, data.saldoCantidad, data.saldoCosto, data.costoPromedio, data.precioVenta , data.esVenta);
        // Asigna objeto a controles
        $("#id").val(data.id);
        $("#codigo").val(data.codigo);
        $("#nombre").val(data.nombre);
        $("#txtColor").val(data.txtColor);
        $("#bgColor").val(data.bgColor);
        $("#txtColorSpan").css("background-color",data.txtColor);
        $("#bgColorSpan").css("background-color",data.bgColor);
        $("#nombreAbreviado").val(data.nombreAbreviado);
        $("#descripcion").val(data.descripcion);
        $("#saldoCantidad").val(data.saldoCantidad);
        $("#saldoCosto").val(parseFloat(data.saldoCantidad).toFixed(2));
        $("#costoPromedio").val(parseFloat(data.costoPromedio).toFixed(2));
        $("#precioVenta").val(parseFloat(data.precioVenta).toFixed(2));
        $('#tipoProducto option[value=' + data.esVenta + ']').prop("selected", true); // esVenta = tipoProducto.
        $("#tipoProducto").selectpicker("refresh");
        $(".bs-example-modal-lg").modal('toggle');
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

    ValorDefault(){
        $("#saldoCantidad").val('0');
        $("#saldoCosto").val('0.00');
        $("#costoPromedio").val('0.00');
        $("#precioVenta").val('0.00');
    }

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