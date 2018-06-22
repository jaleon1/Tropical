class OrdenCompra {
    // Constructor
    constructor(id, orden, fecha, idprodveedor, idusuario, lista) {        
        this.id = id || null;        
        this.orden = orden || '';
        this.fecha = fecha || '';
        this.idprodveedor = idprodveedor || '';
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

    LoadInsumo() {
        if ($("#p_searh").val() != ""){
            insumo.codigo = $("#p_searh").val();  //Columna 0 de la fila seleccionda= ID.
            //
            $.ajax({
                type: "POST",
                url: "class/Insumo.php",
                data: {
                    action: "ReadByCode",
                    obj: JSON.stringify(insumo)
                }
            })
            .done(function (e) {
                ordencompra.ValidateInsumoFac(e);
            })
            .fail(function (e) {
                ordencompra.showError(e);
            });
        }
    };

    LoadArticulo() {
        if ($("#p_searh").val() != ""){
            producto.codigo =  $("#p_searh").val();
            //
            $.ajax({
                type: "POST",
                url: "class/Producto.php",
                data: {
                    action: "ReadArticuloByCode",
                    obj: JSON.stringify(producto)
                }
            })
            .done(function (e) {
                ordencompra.ResetSearch();
                ordencompra.ValidateInsumoFac(e);
            })
            .fail(function (e) {
                ordencompra.showError(e);
            });
        }
    };

    // valida que el insumo nuevo a ingresar no este en la lista
    // si esta en la lista lo suma a la cantidad
    // si es nuevo lo agrega a la lista
    ValidateInsumoFac(e){
        //compara si el articulo ya existe
        // carga lista con datos.
        if(e != "false"){
            insumo = JSON.parse(e)[0];
            insumo.UltPrd = insumo.codigo;
            var repetido = false;
            //
            if(document.getElementById("productos").rows.length != 0 && insumo != null){
                $(document.getElementById("productos").rows).each(function(i,item){
                    if(item.childNodes[0].innerText==insumo.codigo){
                        //item.childNodes[3].childNodes["0"].attributes[3].value = producto.cantidad;
                        //var CantAct = parseInt(item.childNodes[3].firstElementChild.value);
                        //if (parseInt(producto.cantidad) > CantAct ){
                        //    item.childNodes[3].firstElementChild.value = parseFloat(item.childNodes[3].firstElementChild.value) + 1;
                        //}
                        // else{
                        //     // alert("No hay mas de este producto");
                        //     alertSwal(producto.cantidad)
                        //     // $("#cant_"+ producto.UltPrd).val($("#cant_"+ producto.UltPrd)[0].attributes[3].value); 
                        //     $("#cant_"+ producto.UltPrd).val(producto.cantidad);
                        // }
                        repetido=true;
                        swal({
                            type: 'warning',
                            title: 'Orden de Compra',
                            text: 'El item ' + producto.codigo + ' ya se encuentra en la lista',
                            showConfirmButton: false,
                            timer: 3000
                        });
                        
                    }     
                });
            }    
            if (repetido==false){
                // showDataProducto(e);
                ordencompra.AgregaInsumo();
                ordencompra.ResetSearch();
            }
        }
        else{
            ordencompra.LoadArticulo();
        }
    };

    ValidateArticuloFac(e){
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
                ordencompra.AgregaInsumo();
                ordencompra.ResetSearch();
            }
        }
        else{
            ordencompra.ResetSearch();
        }
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

    //Agrega el insumo a la factura
    AgregaInsumo(){
        //insumo.UltPro = insumo.codigo;
        var rowNode = t   //t es la tabla de insumos
        .row.add( [insumo.id, insumo.codigo, insumo.nombre,"Precio Unitario", "0", "0", "0" , "0","0" ])
        .draw() //dibuja la tabla con el nuevo insumo
        .node();     
        //
        $('td:eq(2) input', rowNode).attr({id: ("prec_"+insumo.codigo), max:  "9999999999", min: "0", step:"1", value:"1" }).change(function(){
            ordencompra.CalcImporte($(this).parents('tr').find('td:eq(0)').html());
        });
        //
        $('td:eq(3) input', rowNode).attr({id: ("cantBueno_"+insumo.codigo), max:  "9999999999", min: "1", step:"1", value:"1"}).change(function(){
             ordencompra.CalcImporte($(this).parents('tr').find('td:eq(0)').html());
        });

        //$('td:eq(4)', rowNode).attr({id: ("cantMalo_"+insumo.codigo)});
        $('td:eq(4) input', rowNode).attr({id: ("cantMalo_"+insumo.codigo), max:  "9999999999", min: "0", step:"1", value:"0"}).change(function(){
             ordencompra.CalcImporte($(this).parents('tr').find('td:eq(0)').html());
        });
        //
        $('td:eq(5) input.valor', rowNode).attr({id: ("valorBueno_v"+insumo.codigo), style: "display:none"});
        $('td:eq(5) input.display', rowNode).attr({id: ("valorBueno_d"+insumo.codigo)});    
        $('td:eq(6) input.valor', rowNode).attr({id: ("valorMalo_v"+insumo.codigo), style: "display:none"});
        $('td:eq(6) input.display', rowNode).attr({id: ("valorMalo_d"+insumo.codigo)});
        $('td:eq(7) input.valor', rowNode).attr({id: ("subtotal_v"+insumo.codigo), style: "display:none"});
        $('td:eq(7) input.display', rowNode).attr({id: ("subtotal_d"+insumo.codigo)});   
        //t.order([0, 'desc']).draw();
        t.columns.adjust().draw();
        //calcTotal();
        //$('#open_modal_fac').attr("disabled", false);
    };

    //Calcula el nuevo importe al cambiar la cantidad del prodcuto seleccionado de forma manual y no por insumo repetido.
    CalcImporte(prd){
        //alert('calculando');
        insumo.UltPrd = prd;//validar
        insumo.precio = $(`#prec_${prd}`).val();
        insumo.cantBueno =  $(`#cantBueno_${prd}`).val();
        insumo.cantMalo =  $(`#cantMalo_${prd}`).val();
        insumo.valorBueno=  parseFloat(insumo.precio) * parseInt(insumo.cantBueno);
        insumo.valorMalo=  parseFloat(insumo.precio) * parseInt(insumo.cantMalo);
        insumo.subtotal= insumo.valorBueno + insumo.valorMalo; // subtotal linea
        //
        $(`#valorBueno_v${prd}`).val(insumo.valorBueno.toFixed(10));
        $(`#valorBueno_d${prd}`).val("$"+insumo.valorBueno.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        $(`#valorMalo_v${prd}`).val(insumo.valorMalo.toFixed(10));
        $(`#valorMalo_d${prd}`).val("$"+insumo.valorMalo.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        $(`#subtotal_v${prd}`).val(insumo.subtotal.toFixed(10));
        $(`#subtotal_d${prd}`).val("$"+insumo.subtotal.toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    };

    Init() {
        // validator.js
        // var validator = new FormValidator({ "events": ['blur', 'input', 'change'] }, document.forms["frmProducto"]);
        // $('#frmProducto').submit(function (e) {
        //     e.preventDefault();
        //     var validatorResult = validator.checkAll(this);
        //     if (validatorResult.valid)
        //         producto.Save;
        //     return false;
        // });

        // // on form "reset" event
        // if($('#frmProducto').length > 0 )
        //     document.forms["frmProducto"].onreset = function (e) {
        //         validator.reset();
        // } 
    };
}

let ordencompra = new OrdenCompra();

