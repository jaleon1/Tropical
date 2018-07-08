class Distribucion {
    // Constructor
    constructor(id, orden, fecha, idUsuario, idBodega, porcentajeDescuento, porcentajeIva, lista) {
        this.id = id || null;        
        this.orden = orden || '';
        this.fecha = fecha || '';
        this.idUsuario = idUsuario || null;
        this.idBodega = idBodega || null;
        this.porcentajeDescuento = porcentajeDescuento || 0;
        this.porcentajeIva = porcentajeIva || 0;
        this.lista = lista || [];
    }

    get Save() {
        if($('# tr').length==0 ){
            swal({
                type: 'warning',
                title: 'Orden de Compra',
                text: 'Debe agregar items a la lista',
                showConfirmButton: false,
                timer: 3000
            });
            return;
        }
        //
        $('#btnDistribucion').attr("disabled", "disabled");
        var miAccion = distr.id == null ? 'Create' : 'Update';        
        distr.orden = $("#orden").val();
        distr.idBodega = bodega.id;
        distr.porcentajeDescuento = $("#desc_100").val();
        distr.porcentajeIva=$("#iv_100").val();
        //
        distr.lista = [];
        $('#productos tr').each(function(i, item) {
            var objlista = new Object();
            objlista.idProducto= $('#').dataTable().fnGetData(item)[0]; // id del item.
            objlista.cantidad= $(this).find('td:eq(3) input').val();
            objlista.valor= $(this).find('td:eq(4) input').val(); // valor: precio de venta para distrcion bodega externa. 
            distr.lista.push(objlista);
        });
        $.ajax({
            type: "POST",
            url: "class/Distribucion.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(function(e){
                // muestra el numero de orden: IMPRIMIR.
                var data = JSON.parse(e)[0];
                swal({
                    type: 'success',
                    title: 'Número de Orden:' + data.orden,
                    text: 'Número de orden de Distribución:',
                    showConfirmButton: true
                });
            })
            .fail(function (e) {
                distr.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnDistribucion").removeAttr("disabled")', 1000);
                distr = new Distribucion();
                distr.CleanCtls();
                $("#p_searh").focus();
            });
    };

    get ReadbyOrden() {
        $('#orden').attr("disabled", "disabled");
        var miAccion = 'ReadbyOrden';
        distr.orden= $('#p_searh').val();
        $.ajax({
            type: "POST",
            url: "class/Distribucion.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(function (e) {
                if(e=='null' || e=='')
                {
                    swal({
                        
                        type: 'warning',
                        title: 'Orden no encontrada!',
                        showConfirmButton: false,
                        timer: 1000
                    });
                }
                else distr.ShowItemData(e);
            })
            .fail(function (e) {
                distr.showError(e);
            })
            .always(function () {
                setTimeout('$("#orden").removeAttr("disabled")', 1000);
            });
    }

    Aceptar(){
        $('#btnDistribucion').attr("disabled", "disabled");
        var miAccion = "Aceptar";
        distr.lista = [];
        $('#productos tr').each(function(i, item) {
            var objlista = new Object();
            objlista.idProducto= $('#').dataTable().fnGetData(item)[0]; // id del item.
            objlista.cantidad= $(this).find('td:eq(3) input').val();
            objlista.costo= $(this).find('td:eq(4) input').val(); // costo: precio de venta para distrcion bodega externa. 
            objlista.valor= parseFloat(parseInt(objlista.cantidad) * parseFloat(objlista.costo).toFixed(10)).toFixed(10); // valor. costo*cantidad.
            distr.lista.push(objlista);
        });
        $.ajax({
            type: "POST",
            url: "class/Distribucion.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(distr.showInfo)
            .fail(function (e) {
                distr.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnDistribucion").removeAttr("disabled")', 1000);
                distr = new Distribucion();
                distr.CleanCtls();
                $("#p_searh").focus();
            });

    }

    Reload(e) {
        if (this.id == null)
            this.ShowAll(e);
        else this.ShowItemData(e);
    };

    ShowItemData(e) {
        // Limpia el controles
        this.CleanCtls();
        // carga objeto.
        var data = JSON.parse(e);
        distr = new Distribucion(data.id, data.orden, data.fecha, data.idUsuario, data.idBodega, data.porcentajeDescuento, data.porcentajeIva, data.lista);
        // datos
        $('#orden').val(distr.orden);
        $('#fecha').val(distr.fecha);
        bodega.id= distr.idBodega;
        bodega.Read;
        // carga lista.
        $.each(distr.lista, function (i, item) {
            producto= item;
            distr.AgregaProducto();
        });
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

    CleanCtls() {
        $("#p_searh").val('');
        $('#proveedor').val("");
        $('#orden').val("");
        $('#productos').html("");
        t.rows().remove().draw();
        // totales
        $("#subTotal")[0].textContent = "¢0"; 
        $("#desc_val")[0].textContent = "¢0";
        $("#iv_val")[0].textContent = "¢0";
        $("#total")[0].textContent = "¢0";
    };

    ResetSearch() {
        $("#p_searh").val('');
    };

    LoadProducto() {
        if ($("#p_searh").val() != ""){
            producto.codigo =  $("#p_searh").val();
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
                distr.ResetSearch();
                distr.ValidateProductoFac(e);
            })
            .fail(function (e) {
                distr.showError(e);
            });
        }
    };

    ValidateProductoFac(e){
        //compara si el articulo ya existe
        // carga lista con datos.
        if(e != "false"){
            producto = JSON.parse(e)[0];
            var repetido = false;
            if(document.getElementById("productos").rows.length != 0 && producto != null){
                $(document.getElementById("productos").rows).each(function(i,item){
                    if(item.childNodes[0].innerText==producto.codigo){
                        swal({
                            type: 'warning',
                            title: 'El producto '+ producto.codigo +' ya se encuentra en la lista.',
                            //text: '',
                            showConfirmButton: false,
                            timer: 3000
                        });
                    }     
                });
            }    
            if (repetido==false)
                distr.AgregaProducto();
        }
        else{
            swal({
                type: 'warning',
                title: 'El producto '+ producto.codigo +' NO existe.',
                //text: 'Debe agregar el producto a la lista',
                showConfirmButton: false,
                timer: 3000
            });
        }
    };

    AgregaProducto(){
        var rowNode = this.t   //t es la tabla de productos
        .row.add( [producto.id, producto.codigo, producto.nombre, producto.descripcion, "0", producto.precioVenta, "0"])
        .draw() //dibuja la tabla con el nuevo producto
        .node();     
        //
        $('td:eq(3) input', rowNode).attr({id: ("cant_"+producto.codigo), max:  "9999999999", min: "1", step:"1", value: producto.cantidad || 1}).change(function(){
             distr.CalcImporte($(this).parents('tr').find('td:eq(0)').html());
        }); 
        //
        $('td:eq(4) input.valor', rowNode).attr({id: ("precioventa_v"+producto.codigo), style: "display:none", value: producto.precioVenta });
        $('td:eq(4) input.display', rowNode).attr({id: ("precioventa_d"+producto.codigo), value: ("$"+parseFloat(producto.precioVenta).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")) });
        $('td:eq(5) input.valor', rowNode).attr({id: ("subtotal_v"+producto.codigo), style: "display:none"});
        $('td:eq(5) input.display', rowNode).attr({id: ("subtotal_d"+producto.codigo)});   
        //t.order([0, 'desc']).draw();
        t.columns.adjust().draw();
        distr.CalcImporte(producto.codigo);
        //calcTotal();
        //$('#open_modal_fac').attr("disabled", false);
    };

    CalcImporte(prd){
        producto.UltPrd = prd;//validar
        producto.cantidad =  $(`#cant_${prd}`).val();
        producto.precioVenta = $(`#precioventa_v${prd}`).val();
        producto.subTotal= (producto.cantidad * producto.precioVenta).toFixed(10); // subTotal linea
        //
        $(`#subtotal_v${prd}`).val(producto.subTotal);
        $(`#subtotal_d${prd}`).val("¢"+parseFloat(producto.subTotal).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        //
        distr.calcTotal();
    };

    calcTotal(){
        var subTotal=0; 
        distr.porcentajeDescuento=0;
        distr.porcentajeIva=13;
        $('#desc_100').val(distr.porcentajeDescuento);
        $('#iv_100').val(distr.porcentajeIva);
        //
        if($(document.getElementById("productos").rows)["0"].childElementCount>2){
            $('#productos tr').find('td:eq(5)').each(function(i,item){
                subTotal+=  parseFloat(item.childNodes[0].value).toFixed(10);
            });
            $("#subTotal")[0].textContent= "¢"+ parseFloat(subTotal).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            distr.descuento = subTotal * (parseFloat(distr.porcentajeDescuento).toFixed(2) / 100);
            $("#desc_val")[0].textContent= "¢"+ parseFloat(distr.descuento).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            distr.iva = subTotal * (parseFloat(distr.porcentajeIva).toFixed(2) / 100);
            $("#iv_val")[0].textContent= "¢" + parseFloat(distr.iva).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            distr.total= subTotal - distr.descuento + distr.iva;
            $("#total")[0].textContent= "¢" + parseFloat(distr.total).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
        else{
            //$('#open_modal_fac').attr("disabled", true);
            $("#subTotal")[0].textContent = "¢0"; 
            $("#desc_val")[0].textContent = "¢0";
            $("#iv_val")[0].textContent = "¢0";
            $("#total")[0].textContent = "¢0";
            
        }
    };

    setTable(buttons=true, ds='dsItems'){
        this.t= $('#'+ds).DataTable({
            responsive: true,
            info: false,
            columns: [
                {
                    title: "id",
                    data: "id",
                    className: "itemId",                    
                    searchable: false
                },
                { title: "Codigo", data: "codigo" },
                { title: "Nombre", data: "nombre" },
                { title: "Descripción", data: "descripcion" },
                { 
                    title: "Cantidad", 
                    data: "cantidad",
                    defaultContent: '<input class="cantidad form-control" type="number">'
                },
                { 
                    title: "Precio Venta", 
                    data: "precioVenta" ,
                    defaultContent: '<input class="valor"><input readonly class="display">'
                },
                { 
                    title: "Subtotal", 
                    data: "sobtotal",
                    defaultContent: '<input readonly class="valor"><input readonly class="display">'
                },
                {
                    title: "Action",
                    orderable: false,
                    searchable:false,
                    visible: buttons,
                    mRender: function () {
                        return '<a class="update" > <i class="glyphicon glyphicon-edit" > </i> Editar </a> | <a class="delete"> <i class="glyphicon glyphicon-trash"> </i> Eliminar </a>'                            
                    }
                }
            ]
        });
    };
}


let distr = new Distribucion();