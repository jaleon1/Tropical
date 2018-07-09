var selector = "#txt_pago";

function sendVal(a){
    // a=parseInt(a);
    switch (a) {
        case ((a>=0 && a<=9)?a:-1):
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

function sendRef(a){
    // a=parseInt(a);
    switch (a) {
        case ((a>=0 && a<=9)?a:-1):
           addRef(a);
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

function addNumber(a){
        //21 numeros maximo
        $('.valPago').val($('.valPago').val()+a)   
        validarMonto (); 
};

function addRef(a){
    //21 numeros maximo
    $('.valPago').val($('.valPago').val()+a)   
    validarRef (); 
};

function left(){
    precio=$('.valPago').val();
    $('.valPago').val(precio.substring(0,precio.length-1)); 
    validarMonto (); 
};


function validarMonto (){
    totalXPagar = parseFloat($('#total')["0"].textContent.replace("¢", ""));
    // parseFloat($('#total').val());
    if (( $('.valPago').val() ) >= totalXPagar) {
        var element = document.getElementsByClassName("Nosend")[0];
        element.classList.add("green", "letter", "send");        
        // element.classList.add("letter");
        element.classList.remove("Nosend");
    }
    else {
        var element2 = document.getElementsByClassName("send")[0];
        element2.classList.add("Nosend");
        element2.classList.remove("letter", "send", "green");
    }
};

function validarRef (){
    if (( $('.valPago').length() ) >= 5) {
        var element = document.getElementsByClassName("Nosend")[0];
        element.classList.add("green", "letter", "send");        
        // element.classList.add("letter");
        element.classList.remove("Nosend");
    }
    else {
        var element2 = document.getElementsByClassName("send")[0];
        element2.classList.add("Nosend");
        element2.classList.remove("letter", "send", "green");
    }
};


function enter(){
    crearFactura();
    crearDetalle();
    crearOrden();
};


function crearFactura (){ 
    // INSERT INTO factura (id, fechaCreacion, consecutivo, local, terminal, 
    //                     idCondicionVenta,idSituacionComprobante,idEstadoComprobante, 
    //                     idMedioPago,fechaEmision, totalVenta, totalDescuentos,
    //                     totalVentaneta, totalImpuesto, totalComprobante, idEmisor)

    // VALUES (uuid(), "2018-07-08 22:00", "000000003", "001", "00001", 
    //         1, 1, "1",
    //         1, "Dom 08 de julio 2018", 18.00000,18.00000,
    //         18.00000, 18.00000, 18.00000,uuid());

    var miAccion = 'Create';    
    var prdVenta = new Object();    
   
    $(t.rows().data()).each(function (i, item) {
        prdVenta.idTamano =  item[0];
        prdVenta.idSabor1 = item[2];
        prdVenta.idSabor2 = item[4];
        prdVenta.idTopping = item[6];
        prdVenta.detalle = `${item[1]}, ${item[3]}, ${item[5]}, ${item[7]}`;     
        prdVenta.numLinea = i; 
        prdVenta.cant = 1;

        $.ajax({
            type: "POST",
            url: "class/OrdenXFactura.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(prdVenta)
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
            location.reload();
        });
    });
   

};


function crearDetalle(){
    // INSERT INTO productosXFactura   (id, idFactura, idPrecio, numeroLinea, cantidad, idUnidadMedida,
    //                                 detalle, precioUnitario, montoTotal, 
    //                                 subTotal, montoTotalLinea)
    // VALUES  (uuid(), uuid(), uuid(), 5, 1.000, 33, 
    //         "COPOS", 18.00000, 18.00000,
    //         18.00000, 18.00000);

    var miAccion = 'Create';    
    var prdVenta = new Object();

    prdVenta.idFactura="3b31b046-75eb-11e8-abed-f2f00eda2018";


    $(t.rows().data()).each(function (i, item) {
        prdVenta.idTamano =  item[0];
        prdVenta.idSabor1 = item[2];
        prdVenta.idSabor2 = item[4];
        prdVenta.idTopping = item[6];
        prdVenta.detalle = `${item[1]}, ${item[3]}, ${item[5]}, ${item[7]}`;      

        $.ajax({
            type: "POST",
            url: "class/OrdenXFactura.php",
            data: {
                action: miAccion,
                obj: JSON.stringify(prdVenta)
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
            location.reload();
        });
    });

};