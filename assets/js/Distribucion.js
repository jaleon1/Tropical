class Distribucion {
    // Constructor
    constructor(id, orden, fecha, idusuario, idbodega, porcentajedescuento, porcentajeiva, lista) {
        this.id = id || null;        
        this.orden = orden || '';
        this.fecha = fecha || '';
        this.idusuario = idusuario || null;
        this.idbodega = idbodega || null;
        this.porcentajedescuento = porcentajedescuento || 0;
        this.porcentajeiva = porcentajeiva || 0;
        this.lista = lista || [];
    }

    get Save() {
        if($('#dsitems tr').length==0 ){
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
        distr.idbodega = bodega.id;
        distr.porcentajedescuento = $("#desc_100").val();
        distr.porcentajeiva=$("#iv_100").val();
        //
        distr.lista = [];
        $('#productos tr').each(function(i, item) {
            var objlista = new Object();
            objlista.idproducto= $('#dsitems').dataTable().fnGetData(item)[0]; // id del item.
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
                        position: 'top-end',
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
            objlista.idproducto= $('#dsitems').dataTable().fnGetData(item)[0]; // id del item.
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
        distr = new Distribucion(data.id, data.orden, data.fecha, data.idusuario, data.idbodega, data.porcentajedescuento, data.porcentajeiva, data.lista);
        // datos
        $('#orden').val(distr.orden);
        $('#fecha').val(distr.fecha);
        bodega.id= distr.idbodega;
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

    CleanCtls() {
        $("#p_searh").val('');
        $('#proveedor').val("");
        $('#orden').val("");
        $('#productos').html("");
        t.rows().remove().draw();
        // totales
        $("#subtotal")[0].textContent = "¢0"; 
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
            producto.UltPrd = producto.codigo;
            var repetido = false;

            if(document.getElementById("productos").rows.length != 0 && producto != null){
                $(document.getElementById("productos").rows).each(function(i,item){
                    if(item.childNodes[0].innerText==producto.codigo){
                        item.childNodes[3].childNodes["0"].attributes[3].value = producto.cantidad;
                        var CantAct = parseInt(item.childNodes[3].firstElementChild.value);
                        if (parseInt(producto.cantidad) > CantAct ){
                            item.childNodes[3].firstElementChild.value = parseFloat(item.childNodes[3].firstElementChild.value) + 1;
                        }
                        // else{
                        //     // alert("No hay mas de este producto");
                        //     alertSwal(producto.cantidad)
                        //     // $("#cant_"+ producto.UltPrd).val($("#cant_"+ producto.UltPrd)[0].attributes[3].value); 
                        //     $("#cant_"+ producto.UltPrd).val(producto.cantidad);
                        // }
                        repetido=true;
                        
                    }     
                });
            }    
            if (repetido==false){
                // showDataProducto(e);
                distr.AgregaProducto();
                distr.ResetSearch();
            }
        }
        else{
            distr.ResetSearch();
        }
    };

    AgregaProducto(){
        //producto.UltPro = producto.codigo;
        var rowNode = t   //t es la tabla de productos
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
        producto.subtotal= (producto.cantidad * producto.precioVenta).toFixed(10); // subtotal linea
        //
        $(`#subtotal_v${prd}`).val(producto.subtotal);
        $(`#subtotal_d${prd}`).val("¢"+parseFloat(producto.subtotal).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        //
        distr.calcTotal();
    };

    calcTotal(){
        var subtotal=0; 
        distr.porcentajedescuento=0;
        distr.porcentajeiva=13;
        $('#desc_100').val(distr.porcentajedescuento);
        $('#iv_100').val(distr.porcentajeiva);
        //
        if($(document.getElementById("productos").rows)["0"].childElementCount>2){
            $('#productos tr').find('td:eq(5)').each(function(i,item){
                subtotal+=  parseFloat(item.childNodes[0].value).toFixed(10);
            });
            $("#subtotal")[0].textContent= "¢"+ parseFloat(subtotal).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            distr.descuento = subtotal * (parseFloat(distr.porcentajedescuento).toFixed(2) / 100);
            $("#desc_val")[0].textContent= "¢"+ parseFloat(distr.descuento).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            distr.iva = subtotal * (parseFloat(distr.porcentajeiva).toFixed(2) / 100);
            $("#iv_val")[0].textContent= "¢" + parseFloat(distr.iva).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            distr.total= subtotal - distr.descuento + distr.iva;
            $("#total")[0].textContent= "¢" + parseFloat(distr.total).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }
        else{
            //$('#open_modal_fac').attr("disabled", true);
            $("#subtotal")[0].textContent = "¢0"; 
            $("#desc_val")[0].textContent = "¢0";
            $("#iv_val")[0].textContent = "¢0";
            $("#total")[0].textContent = "¢0";
            
        }
    };
}


let distr = new Distribucion();