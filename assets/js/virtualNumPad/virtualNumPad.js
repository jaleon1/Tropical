var selector = "#txt_pago";

function sendVal(a) {
    localStorage.setItem("lsTarjetaCredito", "0.00");
    localStorage.setItem("lsEfectivo", document.getElementById("txt_pagoCash").value);
    localStorage.setItem("lsVuelto", (document.getElementById("vuelto").innerHTML).substr(11));
    localStorage.setItem("lsDif", "0.00");
    // a=parseInt(a);
    switch (a) {
        case ((a >= 0 && a <= 9) ? a : -1):
            addNumber(a);
            break;
        case ("enter"):
            enter();
            break;
        case ("left"):
            left();
            break;
        default:
            return false
    };
};

function sendRef(a) {
    localStorage.setItem("lsTarjetaCredito", (document.getElementById("total_pagar").innerHTML).substr(16));
    localStorage.setItem("lsEfectivo", "0.00");
    localStorage.setItem("lsVuelto", "0.00");
    localStorage.setItem("lsDif", "0.00");
    // a=parseInt(a);
    switch (a) {
        case ((a >= 0 && a <= 9) ? a : -1):
            addRef(a);
            break;
        case ("enter"):
            enter();
            break;
        case ("left"):
            leftRef();
            break;
        default:
            return false
    };
};

function addNumber(a) {
    //21 numeros maximo
    $('.valPago').val($('.valPago').val() + a)
    validarMonto();
};

function addRef(a) {
    //21 numeros maximo
    $('.valRef').val($('.valRef').val() + a)
    validarRef();
};

function left() {
    precio = $('.valPago').val();
    $('.valPago').val(precio.substring(0, precio.length - 1));
    validarMonto();
};

function leftRef() {
    precio = $('.valRef').val();
    $('.valRef').val(precio.substring(0, precio.length - 1));
    validarRef();
};


function validarMonto() {
    totalXPagar = parseFloat($('#total')["0"].textContent.replace("¢", ""));
    // parseFloat($('#total').val());
    if (($('.valPago').val()) >= totalXPagar) {
        document.getElementById('vuelto').style.color = '#FF0000';

        document.getElementById("vuelto").textContent = ("Su vuelto: " + ((totalXPagar * -1) + parseFloat($('.valPago').val())).toString());

        var element = document.getElementsByClassName("Nosend")[0];
        element.classList.add("green", "letter", "send");
        // element.classList.add("letter");
        element.classList.remove("Nosend");
    } else {
        document.getElementById('vuelto').style.color = '#73879C';

        document.getElementById("vuelto").textContent = ("Su vuelto: ");
        if (document.getElementsByClassName("send")[0]) {
            var element2 = document.getElementsByClassName("send")[0];
            // element2.classList.add("Nosend");
            element2.classList.remove("letter", "send", "green");
        }
    }
};

function validarRef() {
    if (($('.valRef')["0"].value.length) >= 5) {
        var element = document.getElementsByClassName("Nosend")[0];
        element.classList.add("green", "letter", "send");
        // element.classList.add("letter");
        element.classList.remove("Nosend");
    } else {
        if (document.getElementsByClassName("send")[0]) {
            var element2 = document.getElementsByClassName("send")[0];
            element2.classList.add("Nosend");
            element2.classList.remove("letter", "send", "green");
        }
    }
};


function enter() {
    $("#modalFormaPago").attr("disabled", "disabled");
    $(".input_pago").attr("disabled", "disabled");
    $(".close").attr("disabled", "disabled");

    $('.factura-modal-lg').modal({
        backdrop: 'static',
        keyboard: false
    });
    facturar();
};


function crearFactura() {

    var miAccion = 'Create';
    var facVenta = new Object();
    facVenta.totalVenta = 0;

    $(t.rows().data()).each(function (i, item) {

        switch (item[0]) {
            case (0):
                facVenta.totalVenta = facVenta.totalVenta + parseFloat(precioMediano);
                break;
            case (1):
                facVenta.totalVenta = facVenta.totalVenta + parseFloat(precioGrande);
                break;
        };

        $.ajax({
            type: "POST",
            url: "class/Factura.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(facVenta)
            }
        })
            .done(function (e) {
                // muestra el numero de orden: IMPRIMIR.
                //var facUUID = JSON.parse(e)[0];    
                var facUUID = "3b31b046-75eb-11e8-abed-f2f00eda2018";
                crearDetalle(facUUID);
                // swal({
                //     type: 'success',
                //     title: 'Número de Orden:' + data.orden,
                //     text: 'Número de orden de Distribución:',
                //     showConfirmButton: true
                // });
            })
            .fail(function (e) {
                distr.showError(e);
            })
        // .always(function () {
        //     location.reload();
        // });
    });


};

function crearDetalle(facUUID) {
    // INSERT INTO productosXFactura   (id, idFactura, idPrecio, numeroLinea, cantidad, idUnidadMedida,
    //                                 detalle, precioUnitario, montoTotal, 
    //                                 subTotal, montoTotalLinea)
    // VALUES  (uuid(), uuid(), uuid(), 5, 1.000, 33, 
    //         "COPOS", 18.00000, 18.00000,
    //         18.00000, 18.00000);

    var miAccion = 'Create';
    var prdVenta = new Object();
    prdVenta.idFactura = facUUID;

    $(t.rows().data()).each(function (i, item) {
        switch (item[0]) {
            case (0):
                prdVenta.totalVenta = parseFloat(precioMediano);
                break;
            case (1):
                prdVenta.totalVenta = parseFloat(precioGrande);
                break;
        };
        prdVenta.numeroLinea = i;
        // prdVenta.idTamano =  item[0];
        // prdVenta.idSabor1 = item[2];
        // prdVenta.idSabor2 = item[4];
        // prdVenta.idTopping = item[6];
        prdVenta.detalle = `${item[1]}, ${item[3]}, ${item[5]}, ${item[7]}`;

        $.ajax({
            type: "POST",
            url: "class/productoXFactura.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(prdVenta)
            }
        })
            .done(function (e) {
                // muestra el numero de orden: IMPRIMIR.
                // var facUUID = JSON.parse(e)[0];
                var facUUID = "3b31b046-75eb-11e8-abed-f2f00eda2018";
                crearOrden(facUUID);
                // swal({
                //     type: 'success',
                //     title: 'Número de Orden:' + data.orden,
                //     text: 'Número de orden de Distribución:',
                //     showConfirmButton: true
                // });
            })
            .fail(function (e) {
                distr.showError(e);
            })
        // .always(function () {
        //     location.reload();
        // });
    });

};

function crearOrden(facUUID) {
    // INSERT INTO detalleOrden (id, tamano, idFactura, idSabor1, idSabor2, idTopping, estado)
    // VALUES (uuid(), 1, uuid(), uuid(), uuid(), uuid(), 1);

    var miAccion = 'Create';
    var newOrden = new Object();
    newOrden.idFactura = facUUID;

    $(t.rows().data()).each(function (i, item) {
        newOrden.idTamano = item[0];
        newOrden.idSabor1 = item[2];
        newOrden.idSabor2 = item[4];
        newOrden.idTopping = item[6];

        $.ajax({
            type: "POST",
            url: "class/OrdenXFactura.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(newOrden)
            }
        })
            .done(function (e) {
                swal({
                    type: 'success',
                    // title: 'Número de Orden:' + data.orden,
                    text: 'Número de orden de Distribución:',
                    showConfirmButton: true
                });
            })
            .fail(function (e) {
                distr.showError(e);
            })
            .always(function () {
                location.reload();
            });
    });

};


function facturar() {

    $("#keyboard li").css("pointer-events", "none");

    var element = document.getElementsByClassName("send")[0];
    element.classList.add("green", "letter", "Nosend");
    // element.classList.add("letter");
    element.classList.remove("send");

    var miAccion = 'Create';
    facturaCli.totalVenta = 0;
    facturaCli.totalDescuentos = 0;
    facturaCli.totalVentaneta = 0;
    facturaCli.totalImpuesto = 0;
    facturaCli.totalComprobante = 0;
    facturaCli.montoEfectivo = 0;
    facturaCli.montoTarjeta = 0;
    // detalle.
    facturaCli.detalleFactura = [];
    facturaCli.detalleOrden = [];
    $(t.rows().data()).each(function (i, item) {
        var precioUnitario;
        var idPrecio;
        switch (item[0]) {
            case (0):
                precioUnitario = parseFloat((precioMediano.precio / 1.13).toFixed(5)); // resta el iv.
                idPrecio = precioMediano.id;
                break;
            case (1):
                precioUnitario = parseFloat((precioGrande.precio / 1.13).toFixed(5)); // resta el iv.
                idPrecio = precioGrande.id;
                break;
        };
        var objetoDetalleFactura = new Object();
        objetoDetalleFactura.idPrecio = idPrecio;
        objetoDetalleFactura.numeroLinea = i + 1;
        objetoDetalleFactura.idTipoCodigo = 1; // 1 = codigo de vendedor
        objetoDetalleFactura.codigo = item[1];
        objetoDetalleFactura.cantidad = 1;
        objetoDetalleFactura.idUnidadMedida = 78; // 78 =  unidades.
        objetoDetalleFactura.detalle = `${item[1]}, ${item[3]}, ${item[5]}, ${item[7]}`;
        objetoDetalleFactura.precioUnitario = precioUnitario;
        objetoDetalleFactura.montoTotal = parseFloat((objetoDetalleFactura.precioUnitario * objetoDetalleFactura.cantidad).toFixed(5));
        objetoDetalleFactura.montoDescuento = 0;
        objetoDetalleFactura.naturalezaDescuento = 'No aplican descuentos';
        objetoDetalleFactura.subTotal = parseFloat((objetoDetalleFactura.montoTotal - objetoDetalleFactura.montoDescuento).toFixed(5));
        // exoneracion
        //objetoDetalleFactura.idExoneracionImpuesto = null;
        // iv
        // objetoDetalleFactura.codigoImpuesto = 1; // 1 = Impuesto General sobre las Ventas.
        // objetoDetalleFactura.tarifaImpuesto = 13;
        // objetoDetalleFactura.montoImpuesto = parseFloat((objetoDetalleFactura.subTotal * (objetoDetalleFactura.tarifaImpuesto / 100)).toFixed(5)); // debe tomar el impuesto como parametro de un tabla.
        // objetoDetalleFactura.montoTotalLinea = parseFloat((objetoDetalleFactura.subTotal + objetoDetalleFactura.montoImpuesto).toFixed(5));
        // facturaCli.detalleFactura.push(objetoDetalleFactura);

        //
        // iva
        //
        objetoDetalleFactura.impuestos = [];
        var montoTotalImpuestosLinea = 0; // sumatoria de iva de la linea.      
        //if(/* TIENE IMPUESTOS */){
        impuesto = new Object();
        impuesto.idCodigoImpuesto = 1; // 1 = Impuesto Valor Agregado.
        impuesto.codigoTarifa = 8;
        impuesto.tarifa = 13;
        impuesto.monto = parseFloat((objetoDetalleFactura.subTotal * (impuesto.tarifa / 100)).toFixed(5));
        montoTotalImpuestosLinea += impuesto.monto;

        objetoDetalleFactura.montoTotalLinea = parseFloat((objetoDetalleFactura.subTotal + montoTotalImpuestosLinea).toFixed(5));
        objetoDetalleFactura.impuestos.push(impuesto);
        
        facturaCli.detalleFactura.push(objetoDetalleFactura);

        // actualiza totales de factura.
        facturaCli.totalVenta = parseFloat((facturaCli.totalVenta + objetoDetalleFactura.montoTotal).toFixed(5));
        facturaCli.totalDescuentos = parseFloat((facturaCli.totalDescuentos + objetoDetalleFactura.montoDescuento).toFixed(5));
        facturaCli.totalImpuesto = parseFloat((facturaCli.totalImpuesto + objetoDetalleFactura.montoImpuesto).toFixed(5));
        //
        var objetoDetalleOrden = new Object();
        objetoDetalleOrden.idTamano = item[0];
        objetoDetalleOrden.idSabor1 = item[2];
        objetoDetalleOrden.idSabor2 = item[4];
        objetoDetalleOrden.idTopping = item[6];
        facturaCli.detalleOrden.push(objetoDetalleOrden);
    });
    // totales de factura.
    // exonera y grava de mercancias y servicios
    if ($("#txt_pagoCash").val() == null)
        facturaCli.montoEfectivo = "0";
    else
        facturaCli.montoEfectivo = $("#txt_pagoCash").val();
    if ($("#total_pagar").text() == null)
        facturaCli.montoTarjeta = "0";
    else
        facturaCli.montoTarjeta = ($("#total_pagar").text()).substring(16);;

    facturaCli.totalServGravados = 0;
    facturaCli.totalServExentos = 0;
    facturaCli.totalMercanciasGravadas = facturaCli.totalVenta;
    facturaCli.totalMercanciasExentas = 0;
    facturaCli.totalGravado = parseFloat((facturaCli.totalServGravados + facturaCli.totalMercanciasGravadas).toFixed(5));
    facturaCli.totalExento = parseFloat((facturaCli.totalServExentos + facturaCli.totalMercanciasExentas).toFixed(5));
    facturaCli.totalVenta = parseFloat((facturaCli.totalGravado + facturaCli.totalExento).toFixed(5));
    // total venta neta.
    facturaCli.totalVentaneta = parseFloat((facturaCli.totalVenta - facturaCli.totalDescuentos).toFixed(5));
    // total comprobante.
    facturaCli.totalComprobante = parseFloat((facturaCli.totalVentaneta + facturaCli.totalImpuesto).toFixed(5));
    //
    $('#send').addClass('Nosend');
    $('#send').attr("disabled", "disabled");
    //
    $.ajax({
        type: "POST",
        url: "class/Factura.php",
        data: {
            action: miAccion,
            obj: JSON.stringify(facturaCli)
        }
    })
        .done(function (e) {
            ticketPrint(e);
        })
        .fail(function (e) {
            swal({
                type: 'error',
                text: 'Error al facturar!',
                timer: 1000
            });
        })
        .always(function () {
            // location.reload();
        });
    // });

    // detalleFactura.totalVenta = lineaXFactura;


    ///////////////////////////////////////
    //           Crea la ORDEN           //
    ///////////////////////////////////////
    // var newOrden = new Object();
    // newOrden.idFactura = facUUID;    

    // $(t.rows().data()).each(function (i, item) {
    //     newOrden[i].idTamano =  item[0];
    //     newOrden[i].idSabor1 = item[2];
    //     newOrden[i].idSabor2 = item[4];
    //     newOrden[i].idTopping = item[6];




}