class OrdenCompra {

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
                CleanCtls();
                ValidateProductFac(e);
            })
            .fail(function (e) {
                showError(e);
            });
        }
    };

    LoadInsumo() {
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
                CleanCtls();
                ValidateProductFac(e);
            })
            .fail(function (e) {
                showError(e);
            });
        }
    };

    // valida que el producto nuevo a ingresar no este en la lista
    // si esta en la lista lo suma a la cantidad
    // si es nuevo lo agrega a la lista
    ValidateProductFac(e){
        //compara si el articulo ya existe
        // carga lista con datos.
        if(e != "false"){
            producto = JSON.parse(e)[0];
            producto.UltPrd = producto.codigo;
            var repetido = false;

            if(document.getElementById("productos").rows.length != 0 && producto != null){
                $(document.getElementById("productos").rows).each(function(i,item){
                    if(item.childNodes[0].innerText==producto.codigoRapido){
                        item.childNodes[3].childNodes["0"].attributes[3].value = producto.cantidad;
                        var CantAct = parseInt(item.childNodes[3].firstElementChild.value);
                        if (parseInt(producto.cantidad) > CantAct ){
                            item.childNodes[3].firstElementChild.value = parseFloat(item.childNodes[3].firstElementChild.value) + 1;
                            item.childNodes[04].firstChild.textContent = "¢" + parseFloat((item.childNodes[2].firstChild.textContent).replace("¢","")) * parseFloat(item.childNodes[3].firstElementChild.value);
                            calcTotal();
                        }
                        else{
                            // alert("No hay mas de este producto");
                            alertSwal(producto.cantidad)
                            // $("#cant_"+ producto.UltPrd).val($("#cant_"+ producto.UltPrd)[0].attributes[3].value); 
                            $("#cant_"+ producto.UltPrd).val(producto.cantidad);
                        }
                        repetido=true;
                        calcTotal();
                    }     
                });
            }    
            if (repetido==false){
                // showDataProducto(e);
                AgregaPrd();
            }
        }
        else{
            CleanCtls();
        }
    };

    CleanCtls() {
        $("#p_searh").val('');
    };

    //Agrega el producto a la factura
    AgregaPrd(){
        producto.UltPro = producto.codigoRapido;
        var rowNode = t   //t es la tabla de productos
        .row.add( [producto.id, producto.codigoRapido, producto.descripcion, "¢"+producto.precio, "1", "¢"+producto.precio])
        .draw() //dibuja la tabla con el nuevo producto
        .node();     
        $('td:eq(2)', rowNode).attr({id: ("prec_"+producto.codigoRapido)});
        $('td:eq(4)', rowNode).attr({id: ("impo_"+producto.codigoRapido)});
        $('td:eq(3) input', rowNode).attr({id: ("cant_"+producto.codigoRapido), max:  producto.cantidad, min: "0", step:"1", value:"1", onchage:"CalcImporte("+producto.codigoRapido+")"});
        $('td:eq(3) input', rowNode).change(function(){
            CalcImporte(producto.codigoRapido);
        });
        t.order([0, 'desc']).draw();
        t.columns.adjust().draw();
        calcTotal();
        $('#open_modal_fac').attr("disabled", false);
    };
}

let ordencompra = new OrdenCopra();

