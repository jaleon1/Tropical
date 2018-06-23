class Distribucion {
    // Constructor
    constructor(id, orden, fecha, idusuario, lista) {
        this.id = id || null;        
        this.orden = orden || '';
        this.fecha = fecha || '';
        this.idusuario = idusuario || '';
        this.lista = lista || [];
    }

    get Save() {
        if($('#productos').length==0 ){
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
        $('#btnOrdenCompra').attr("disabled", "disabled");
        var miAccion = this.id == null ? 'Create' : 'Update';        
        this.orden = $("#orden").val();
        this.idproveedor = $("#proveedor").val();
        //
        ordencompra.lista = [];
        $('#productos tr').each(function(i, item) {
            var objlista = new Object();
            objlista.idinsumo= $('#dsitems').dataTable().fnGetData(item)[0]; // id del item.
            objlista.costounitario= $(this).find('td:eq(2) input').val();
            objlista.cantidadbueno= $(this).find('td:eq(3) input').val();
            objlista.cantidadmalo= $(this).find('td:eq(4) input').val();
            objlista.valorbueno= $(this).find('td:eq(5) input.valor').val();
            objlista.valormalo= $(this).find('td:eq(6) input.valor').val();
            ordencompra.lista.push(objlista);
        });
        $.ajax({
            type: "POST",
            url: "class/OrdenCompra.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(this)
            }
        })
            .done(ordencompra.showInfo)
            .fail(function (e) {
                ordencompra.showError(e);
            })
            .always(function () {
                setTimeout('$("#btnOrdenCompra").removeAttr("disabled")', 1000);
                ordencompra = new OrdenCompra();
                ordencompra.CleanCtls();
                $("#p_searh").focus();
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
        .row.add( [producto.id, producto.codigo, producto.nombre, producto.descripcion, "0", producto.precioventa, "0"])
        .draw() //dibuja la tabla con el nuevo producto
        .node();     
        //
        $('td:eq(3) input', rowNode).attr({id: ("cant_"+producto.codigo), max:  "9999999999", min: "1", step:"1", value:"1"}).change(function(){
             distr.CalcImporte($(this).parents('tr').find('td:eq(0)').html());
        }); 
        //
        $('td:eq(4) input.valor', rowNode).attr({id: ("precioventa_v"+producto.codigo), style: "display:none", value: producto.precioventa });
        $('td:eq(4) input.display', rowNode).attr({id: ("precioventa_d"+producto.codigo), value: ("$"+parseFloat(producto.precioventa).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ",")) });
        $('td:eq(5) input.valor', rowNode).attr({id: ("subtotal_v"+producto.codigo), style: "display:none"});
        $('td:eq(5) input.display', rowNode).attr({id: ("subtotal_d"+producto.codigo)});   
        //t.order([0, 'desc']).draw();
        t.columns.adjust().draw();
        distr.CalcImporte(producto.codigo);
        //calcTotal();
        //$('#open_modal_fac').attr("disabled", false);
    };

    CalcImporte(prd){
        //alert('calculando');
        producto.UltPrd = prd;//validar
        producto.cantidad =  $(`#cant_${prd}`).val();
        producto.precioventa = $(`#precioventa_v${prd}`).val();
        producto.subtotal= producto.cantidad * producto.precioventa; // subtotal linea
        //
        $(`#subtotal_v${prd}`).val(producto.subtotal.toFixed(10));
        $(`#subtotal_d${prd}`).val("$"+producto.subtotal.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    };
}


let distr = new Distribucion();